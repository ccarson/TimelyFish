

-- ===================================================================
-- Author:  Andrey Derco
-- Create date: 11/28/2008
-- Description: Selects data for Purchased Bushels - Basis Report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PURCHASED_BUSHELS_BASIS]
(
    @FeedMillID		varchar(10),
    @CornProducerID	varchar(15),
    @CommodityID	int,
    @CropYear		int
)
AS
BEGIN
SET NOCOUNT ON;

SELECT DeliveryMonthName,
       DeliveryMonthOrder,
       DeliveryType,
       DeliveryTypeOrder,
       CropYearName,
       BasisType,
       BasisTypeOrder,
       ISNULL(CASE DeliveryType
         WHEN 'Producer' THEN 
           CASE BasisType
             WHEN 'Delivered Bushels' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels ELSE 0 END)
             WHEN 'Realized Basis' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels * ISNULL(T.ContractBasis,0) ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels ELSE 0 END) END
             WHEN 'Market Basis' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels * T.MarketBasis ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.DryBushels ELSE 0 END) END
           END
         WHEN 'Elevator' THEN
           CASE BasisType
             WHEN 'Delivered Bushels' THEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels ELSE 0 END)
             WHEN 'Realized Basis' THEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels * ISNULL(T.ContractBasis,0) ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels ELSE 0 END) END
             WHEN 'Market Basis' THEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels * T.ElevatorBasis ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.DryBushels ELSE 0 END) END

           END
         WHEN 'Cash' THEN
           CASE BasisType
             WHEN 'Delivered Bushels' THEN SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels ELSE 0 END)
             WHEN 'Realized Basis' THEN SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels * T.CashBasis ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels ELSE 0 END) END
             WHEN 'Market Basis' THEN SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels * T.MarketBasis ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.DryBushels ELSE 0 END) END
           END
         WHEN 'Unpriced' THEN
           CASE BasisType
             WHEN 'Delivered Bushels' THEN SUM(CASE WHEN T.IsUnpriced = 1 OR T.PaymentTypeIs3 = 1 THEN T.DryBushels ELSE 0 END)
             WHEN 'Realized Basis' THEN SUM(CASE WHEN T.IsUnpriced = 1 AND T.ContractBasis IS NOT NULL THEN T.ContractBasis * T.DryBushels ELSE 0 END) /
              CASE WHEN SUM(CASE WHEN T.IsUnpriced = 1 AND T.ContractBasis IS NOT NULL THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE
                 SUM(CASE WHEN T.IsUnpriced = 1 AND T.ContractBasis IS NOT NULL THEN T.DryBushels ELSE 0 END) END

             WHEN 'Market Basis' THEN SUM(CASE WHEN T.IsUnpriced = 1 THEN T.MarketBasis * T.DryBushels ELSE 0 END) /
              CASE WHEN SUM(CASE WHEN T.IsUnpriced = 1 THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE
                 SUM(CASE WHEN T.IsUnpriced = 1 THEN T.DryBushels ELSE 0 END) END
           END
         WHEN 'Total' THEN
           CASE BasisType
             WHEN 'Delivered Bushels' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1
                                                     OR ISNULL(T.IsElevator, 0) = 1
                                                     OR ISNULL(T.IsCash, 0) = 1
                                                     OR (ISNULL(T.IsUnpriced, 0) = 1 OR T.PaymentTypeIs3 = 1)
                                                   THEN T.DryBushels ELSE 0 END)
             WHEN 'Realized Basis' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 OR ISNULL(T.IsElevator, 0) = 1 
										OR (T.IsUnpriced = 1 AND T.ContractBasis IS NOT NULL)
												  THEN T.ContractBasis
                                              ELSE CASE WHEN ISNULL(T.IsCash, 0) = 1 THEN T.CashBasis ELSE 0 END 
                                            END * T.DryBushels) /                                                     
                                                    CASE WHEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1
                                                     OR ISNULL(T.IsElevator, 0) = 1
                                                     OR ISNULL(T.IsCash, 0) = 1
                                                     OR (ISNULL(T.IsUnpriced, 0) = 1 AND T.ContractBasis IS NOT NULL)
                                                   THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE 
                                                   SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1
                                                     OR ISNULL(T.IsElevator, 0) = 1
                                                     OR ISNULL(T.IsCash, 0) = 1
                                                     OR (ISNULL(T.IsUnpriced, 0) = 1 AND T.ContractBasis IS NOT NULL)
                                                   THEN T.DryBushels ELSE 0 END) END
             WHEN 'Market Basis' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 OR ISNULL(T.IsCash, 0) = 1 OR ISNULL(T.IsUnpriced,0) = 1 THEN T.MarketBasis 
											   WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.ElevatorBasis			
												ELSE 0 END                                        
												* T.DryBushels) /                                                     
                                                    CASE WHEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1
                                                     OR ISNULL(T.IsElevator, 0) = 1
                                                     OR ISNULL(T.IsCash, 0) = 1
                                                     OR ISNULL(T.IsUnpriced, 0) = 1
                                                   THEN T.DryBushels ELSE 0 END) = 0 THEN 1 ELSE 
                                                    SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1
                                                     OR ISNULL(T.IsElevator, 0) = 1
                                                     OR ISNULL(T.IsCash, 0) = 1
                                                     OR ISNULL(T.IsUnpriced, 0) = 1
                                                   THEN T.DryBushels ELSE 0 END) END

           END
       END, 0) AS Value
FROM (
          SELECT 'Producer' AS DeliveryType, 1 AS DeliveryTypeOrder
          UNION SELECT 'Elevator' AS DeliveryType, 2 AS DeliveryTypeOrder                       
          UNION SELECT 'Cash' AS DeliveryType, 3 AS DeliveryTypeOrder
          UNION SELECT 'Unpriced' AS DeliveryType, 4 AS DeliveryTypeOrder
          UNION SELECT 'Total' AS DeliveryType, 5 AS DeliveryTypeOrder
     ) AS DT -- Table of delivery types
CROSS JOIN (
              SELECT 'Delivered Bushels' AS BasisType, 1 AS BasisTypeOrder
              UNION SELECT 'Realized Basis' AS BasisType, 2 AS BasisTypeOrder
              UNION SELECT 'Market Basis' AS BasisType, 3 AS BasisTypeOrder
           ) AS BT --Table of basis types
CROSS JOIN (
              SELECT @CropYear - 3 as CropYear, cast(@CropYear - 3 as varchar) + '-' + cast(@CropYear - 2 as varchar) AS CropYearName
              UNION SELECT @CropYear - 2 as CropYear, cast(@CropYear - 2 as varchar) + '-' + cast(@CropYear - 1 as varchar)
              UNION SELECT @CropYear - 1 as CropYear, cast(@CropYear - 1 as varchar) + '-' + cast(@CropYear as varchar)
              UNION SELECT @CropYear as CropYear, cast(@CropYear as varchar) + '-' + cast(@CropYear + 1 as varchar)
           ) AS CY -- Table of crop years
CROSS JOIN (
              SELECT 10 AS DeliveryMonth, datename(month, '10/01/2008') AS DeliveryMonthName, 1 AS DeliveryMonthOrder
              UNION SELECT 11 AS DeliveryMonth, datename(month, '11/01/2008') AS DeliveryMonthName, 2 AS DeliveryMonthOrder
              UNION SELECT 12 AS DeliveryMonth, datename(month, '12/01/2008') AS DeliveryMonthName, 3 AS DeliveryMonthOrder
              UNION SELECT 1 AS DeliveryMonth, datename(month, '01/01/2008') AS DeliveryMonthName, 4 AS DeliveryMonthOrder
              UNION SELECT 2 AS DeliveryMonth, datename(month, '02/01/2008') AS DeliveryMonthName, 5 AS DeliveryMonthOrder
              UNION SELECT 3 AS DeliveryMonth, datename(month, '03/01/2008') AS DeliveryMonthName, 6 AS DeliveryMonthOrder
              UNION SELECT 4 AS DeliveryMonth, datename(month, '04/01/2008') AS DeliveryMonthName, 7 AS DeliveryMonthOrder
              UNION SELECT 5 AS DeliveryMonth, datename(month, '05/01/2008') AS DeliveryMonthName, 8 AS DeliveryMonthOrder
              UNION SELECT 6 AS DeliveryMonth, datename(month, '06/01/2008') AS DeliveryMonthName, 9 AS DeliveryMonthOrder
              UNION SELECT 7 AS DeliveryMonth, datename(month, '07/01/2008') AS DeliveryMonthName, 10 AS DeliveryMonthOrder
              UNION SELECT 8 AS DeliveryMonth, datename(month, '08/01/2008') AS DeliveryMonthName, 11 AS DeliveryMonthOrder
              UNION SELECT 9 AS DeliveryMonth, datename(month, '09/01/2008') AS DeliveryMonthName, 12 AS DeliveryMonthOrder
           ) AS DM --Table of delivery months


LEFT OUTER JOIN 
(    SELECT  month(PT.DeliveryDate) AS DeliveryMonth, 
       CASE WHEN month(PT.DeliveryDate) >= 10 
         THEN year(PT.DeliveryDate) 
         ELSE year(PT.DeliveryDate) - 1 
       END AS CropYear,
     CASE WHEN PT.PaymentTypeID = 2
          AND C.ContractID IS NOT NULL
          AND (ISNULL(CT.PriceLater, 0) = 1
          OR ISNULL(LCT.PriceLater, 0) = 1
          OR ISNULL(PCT.PriceLater, 0) = 1
          OR ISNULL(PLCT.PriceLater, 0) = 1)
          AND NOT (C.ContractTypeID IN (3,26) AND C.LastContractTypeID IS NULL) 
          --AND NOT(C.PricedBasis IS NULL AND C.FuturesBasis IS NULL) 
       THEN 1 ELSE 0 END AS IsUnpriced,
     CASE WHEN PT.PaymentTypeID = 3
       THEN 1 ELSE 0 END AS PaymentTypeIs3,
     CASE WHEN PT.PaymentTypeID = 1
       OR (C.ContractTypeID IN (3,26) AND C.LastContractTypeID IS NULL) 
       THEN 1 ELSE 0 END AS IsCash,
     CASE WHEN C.ContractID IS NOT NULL 
          AND PT.PaymentTypeID = 2
          AND NOT (ISNULL(CT.PriceLater, 0) = 1
          OR ISNULL(LCT.PriceLater, 0) = 1
          OR ISNULL(PCT.PriceLater, 0) = 1
          OR ISNULL(PLCT.PriceLater, 0) = 1)
          AND ISNULL(CP.Elevator, 0) = 1
          AND NOT (C.ContractTypeID IN (3,26) AND C.LastContractTypeID IS NULL) 
       THEN 1 ELSE 0 END AS IsElevator,
     CASE WHEN C.ContractID IS NOT NULL 
          AND PT.PaymentTypeID = 2
          AND NOT (ISNULL(CT.PriceLater, 0) = 1
          OR ISNULL(LCT.PriceLater, 0) = 1
          OR ISNULL(PCT.PriceLater, 0) = 1
          OR ISNULL(PLCT.PriceLater, 0) = 1)
          AND ISNULL(CP.Elevator, 0) = 0
          AND NOT (C.ContractTypeID IN (3,26) AND C.LastContractTypeID IS NULL) 
       THEN 1 ELSE 0 END AS IsProducer,
     CASE WHEN C.ContractID IS NOT NULL 
          AND PT.PaymentTypeID = 2
       THEN ISNULL(C.FuturesBasis, C.PricedBasis) ELSE 0 END AS ContractBasis,
     CASE WHEN PT.PaymentTypeID = 1 OR (C.ContractTypeID IN (3,26) AND C.LastContractTypeID IS NULL) 
       THEN CASE WHEN Q.QuoteID IS NOT NULL THEN Q.Basis ELSE ISNULL(DPD.CompetitorBasis, 0) + ISNULL(DPD.CompetitorFreight, 0) + ISNULL(DPD.Adj, 0) END 
     END AS CashBasis,
     ISNULL(DPD.CompetitorBasis, 0) + ISNULL(DPD.CompetitorFreight, 0) + ISNULL(DPD.Adj, 0) AS MarketBasis,
     ISNULL((  
         SELECT AVG(Amount)
         FROM dbo.cft_ELEVATOR_SALE_BASIS
         WHERE FeedMillID = FT.FeedMillID AND month(Date) = month(PT.DeliveryDate) AND year(Date) = year(PT.DeliveryDate)
         --ORDER BY Date DESC
     ), 0) AS ElevatorBasis,     
     PT.DryBushels
     FROM dbo.cft_PARTIAL_TICKET PT
       INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
       LEFT OUTER JOIN dbo.cft_CONTRACT C ON PT.ContractID = C.ContractID
       LEFT OUTER JOIN dbo.cft_CORN_PRODUCER CP ON C.CornProducerID = CP.CornProducerID
       LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID  -- contract type
       LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE LCT ON LCT.ContractTypeID = C.LastContractTypeID --last contract type
       LEFT OUTER JOIN dbo.cft_CONTRACT PC ON C.SubsequenceNumber IS NOT NULL AND PC.SequenceNumber = C.SequenceNumber AND PC.SubsequenceNumber IS NULL AND C.FeedMillID = PC.FeedMillID--parent contract
       LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE PCT ON PCT.ContractTypeID = PC.ContractTypeID  -- parent's contract type
       LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE PLCT ON PLCT.ContractTypeID = PC.LastContractTypeID --parent's last contract type
       LEFT OUTER JOIN dbo.cft_QUOTE Q ON Q.QuoteID = PT.QuoteID
       LEFT OUTER JOIN dbo.cft_DAILY_PRICE_DETAIL DPD ON DPD.DailyPriceDetailID = PT.DailyPriceDetailID
       
     WHERE FT.CommodityID = @CommodityID 
           AND FT.FeedMillID LIKE @FeedMillID 
           AND ISNULL(PT.DeliveryCornProducerID,PT.CornProducerID) LIKE @CornProducerID
) AS T ON T.DeliveryMonth = DM.DeliveryMonth AND T.CropYear = CY.CropYear
GROUP BY DeliveryMonthName,DeliveryMonthOrder,DeliveryType,DeliveryTypeOrder,CropYearName,BasisType,BasisTypeOrder
ORDER BY DeliveryMonthOrder,DeliveryTypeOrder,CropYearName,BasisTypeOrder   

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PURCHASED_BUSHELS_BASIS] TO [db_sp_exec]
    AS [dbo];

