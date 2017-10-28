

-- ===================================================================
-- Author:  Andrey Derco
-- Create date: 11/28/2008
-- Description: Selects data for Basis Report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_BASIS]
(
    @FeedMillID		varchar(10),
    @CommodityID	int,
    @StartDate		datetime,
    @EndDate		datetime

)
AS
BEGIN
SET NOCOUNT ON;



DECLARE @MNContingentOfferContractTypeID int,
        @IAContingentOfferContractTypeID int,
        @MNPriceLaterContractTypeID int,
        @IACreditSaleContractTypeID int


SELECT @MNContingentOfferContractTypeID = 1,
       @IAContingentOfferContractTypeID = 23,
       @MNPriceLaterContractTypeID = 20,
       @IACreditSaleContractTypeID  = 25



DECLARE @Dates TABLE
(
  Date datetime
)

DECLARE @CurrentDate datetime

SET @CurrentDate = @StartDate

WHILE @CurrentDate <= @EndDate BEGIN

   IF datepart(weekday,@CurrentDate) NOT IN (1,7) BEGIN
   
     INSERT @Dates(Date) VALUES (@CurrentDate)

   END

  SET @CurrentDate = dateadd(day,1,@CurrentDate)

END




SELECT CASE WHEN D.Date <= getdate() 
         THEN convert(varchar, D.Date, 101) 
         ELSE datename(month, D.Date) + '''' + cast(year(D.Date) as varchar)
       END AS Date,
     MAX(D.Date) As OrderBy,
     AVG(CASE WHEN CR.[Index] = 1 THEN DPDC.Price - PriceData.CBOTCornClose ELSE NULL END) AS [Index],
     CASE WHEN ISNULL(MIN(CASE WHEN CR.UseInAverage = 1 AND DPDC.Price - PriceData.CBOTCornClose > 0 THEN DPDC.Price - PriceData.CBOTCornClose ELSE NULL END), 999999)
       > -1 * ISNULL(MAX(CASE WHEN CR.UseInAverage = 1 AND DPDC.Price - PriceData.CBOTCornClose < 0 THEN DPDC.Price - PriceData.CBOTCornClose ELSE NULL END), -999999)
       THEN MAX(CASE WHEN CR.UseInAverage = 1 AND DPDC.Price - PriceData.CBOTCornClose < 0 THEN DPDC.Price - PriceData.CBOTCornClose ELSE NULL END)
       ELSE MIN(CASE WHEN CR.UseInAverage = 1 AND DPDC.Price - PriceData.CBOTCornClose > 0 THEN DPDC.Price - PriceData.CBOTCornClose ELSE NULL END)
     END AS HighLocalBasis,
     AVG(CASE WHEN CR.UseInAverage = 1 THEN DPDC.Price - PriceData.CBOTCornClose ELSE NULL END) AS AreaAverageBasis,
     AVG(CASE WHEN D.Date <= getdate() THEN ESB.Amount ELSE ESBM.Amount END) AS ElevatorSaleBasis,
     AVG(PriceData.CFFBasis) AS CFFBasis,
     AVG(ContractData.ContractedProducerBasis) AS ContractedProducerBasis,
     AVG(ContractData.ContractedElevatorBasis) AS ContractedElevatorBasis,
     AVG(ContractData.CombinedBasisContracted) AS CombinedBasisContracted
          
FROM @Dates D
LEFT OUTER JOIN (
                     SELECT DP.DailyPriceID,
                            DP.FeedMillID,
                            DPD.DailyPriceDetailID,
                            DPD.DeliveryMonth, 
                            DPD.DeliveryYear ,
                            DPD.CBOTCornClose,
                            DPD.CompetitorBasis + DPD.CompetitorFreight + DPD.Adj AS CFFBasis
                     FROM dbo.cft_DAILY_PRICE DP 
                     INNER JOIN dbo.cft_DAILY_PRICE_DETAIL DPD ON DP.DailyPriceID = DPD.DailyPriceID
                      WHERE DP.FeedMillID LIKE @FeedMillID 
                ) PriceData ON PriceData.DailyPriceID = ( 
                                                             SELECT TOP 1 DailyPriceID
                                                             FROM dbo.cft_DAILY_PRICE 
                                                             WHERE Date <= D.Date AND FeedMillID = PriceData.FeedMillID AND Approved = 1
                                                             ORDER BY Date DESC
                                                        )
                               AND month(D.Date) = PriceData.DeliveryMonth AND year(D.Date) = PriceData.DeliveryYear
LEFT OUTER JOIN dbo.cft_DAILY_PRICE_DETAIL_COMPETITOR DPDC ON DPDC.DailyPriceDetailID = PriceData.DailyPriceDetailID
LEFT OUTER JOIN dbo.cft_COMPETITOR CR ON CR.CompetitorID = DPDC.CompetitorID
LEFT OUTER JOIN dbo.cft_ELEVATOR_SALE_BASIS ESB ON ElevatorSaleBasisID = (  
                                                                               SELECT TOP 1 ElevatorSaleBasisID
                                                                               FROM dbo.cft_ELEVATOR_SALE_BASIS
                                                                               WHERE FeedMillID = PriceData.FeedMillID AND Date <= D.Date
                                                                               ORDER BY Date DESC
                                                                          )
LEFT OUTER JOIN (
                    SELECT year(Date) AS Year,
                           month(Date) AS Month,
                           FeedMillID,
                           AVG(Amount) AS Amount 
                    FROM dbo.cft_ELEVATOR_SALE_BASIS
                    GROUP BY year(Date),
                             month(Date),
                             FeedMillID
                ) ESBM ON ESBM.Month = month(D.Date) AND ESBM.Year = year(D.Date) AND ESBM.FeedMillID = PriceData.FeedMillID

LEFT OUTER JOIN (    
                     SELECT  C.DeliveryMonth, 
                             C.FeedMillID,

                             SUM(CASE WHEN ISNULL(CP.Elevator, 0) = 0 THEN C.Bushels * ISNULL(C.FuturesBasis, C.PricedBasis) ELSE 0 END) / 
                               CASE WHEN SUM(CASE WHEN ISNULL(CP.Elevator, 0) = 0 THEN C.Bushels ELSE 0 END) = 0 
                                 THEN 1 
                                 ELSE SUM(CASE WHEN ISNULL(CP.Elevator, 0) = 0 THEN C.Bushels ELSE 0 END) 
                               END AS ContractedProducerBasis,
                             SUM(CASE WHEN ISNULL(CP.Elevator, 0) = 1 THEN C.Bushels * ISNULL(C.FuturesBasis, C.PricedBasis) ELSE 0 END) / 
                               CASE WHEN SUM(CASE WHEN ISNULL(CP.Elevator, 0) = 1 THEN C.Bushels ELSE 0 END) = 0 
                                 THEN 1 
                                 ELSE SUM(CASE WHEN ISNULL(CP.Elevator, 0) = 1 THEN C.Bushels ELSE 0 END) 
                               END AS ContractedElevatorBasis,
                             SUM(C.Bushels * ISNULL(C.FuturesBasis, C.PricedBasis)) / 
                               CASE WHEN SUM(C.Bushels) = 0 
                                 THEN 1 
                                 ELSE SUM(C.Bushels) 
                               END AS CombinedBasisContracted
                     FROM dbo.cft_CONTRACT C
                     INNER JOIN dbo.cft_CORN_PRODUCER CP ON C.CornProducerID = CP.CornProducerID
                     WHERE C.CommodityID = @CommodityID 
                       AND C.ContractTypeID <> @MNPriceLaterContractTypeID
                       AND C.ContractStatusID <> 3
                       AND NOT (C.FuturesBasis IS NULL AND C.PricedBasis IS NULL)
                     GROUP BY C.DeliveryMonth, 
                              C.FeedMillID  
                ) ContractData ON ContractData.FeedMillID = PriceData.FeedMillID AND ContractData.DeliveryMonth = year(D.Date) * 100 + month(D.Date)


WHERE (D.Date <= getdate()) OR (D.Date > getdate() AND year(D.Date) * 100 + month(D.Date) > year(getdate()) * 100 + month(getdate()))
      AND PriceData.FeedMillID LIKE @FeedMillID
GROUP BY CASE WHEN D.Date <= getdate() 
           THEN convert(varchar, D.Date, 101) 
           ELSE datename(month, D.Date) + '''' + cast(year(D.Date) as varchar)
         END


ORDER BY MAX(D.Date)
         





END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_BASIS] TO [db_sp_exec]
    AS [dbo];

