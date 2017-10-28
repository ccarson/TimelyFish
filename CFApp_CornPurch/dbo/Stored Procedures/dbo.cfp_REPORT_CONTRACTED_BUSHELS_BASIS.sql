

-- ===================================================================
-- Author:  Andrey Derco
-- Create date: 11/28/2008
-- Description: Selects data for Contracted Bushels - Basis Report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CONTRACTED_BUSHELS_BASIS]
(
    @FeedMillID		varchar(10),
    @CornProducerID	varchar(15),
    @CommodityID	int,
    @CropYear		int
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
             WHEN 'Contracted Bushels' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.Bushels ELSE 0 END)
             WHEN 'Basis' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.Bushels * T.Basis ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.Bushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 THEN T.Bushels ELSE 0 END) END
           END
         WHEN 'Elevator' THEN
           CASE BasisType
             WHEN 'Contracted Bushels' THEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.Bushels ELSE 0 END)
             WHEN 'Basis' THEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.Bushels * T.Basis ELSE 0 END) / 
               CASE WHEN SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.Bushels ELSE 0 END) = 0 THEN 1 ELSE SUM(CASE WHEN ISNULL(T.IsElevator, 0) = 1 THEN T.Bushels ELSE 0 END) END
           END
         WHEN 'NBE' THEN
           CASE BasisType
             WHEN 'Contracted Bushels' THEN SUM(CASE WHEN ISNULL(T.IsNBE, 0) = 1 THEN T.Bushels ELSE 0 END)
             WHEN 'Basis' THEN 0
           END
         WHEN 'Contingent' THEN
           CASE BasisType
             WHEN 'Contracted Bushels' THEN SUM(CASE WHEN ISNULL(T.IsContingent, 0) = 1 THEN T.Bushels ELSE 0 END)
             WHEN 'Basis' THEN 0 -- Ok for 0
           END
         WHEN 'Total' THEN
           CASE BasisType
             WHEN 'Contracted Bushels' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 OR ISNULL(T.IsElevator, 0) = 1
                                                     OR ISNULL(T.IsNBE, 0) = 1 OR ISNULL(T.IsContingent, 0) = 1
                                                   THEN T.Bushels ELSE 0 END)
             WHEN 'Basis' THEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 OR ISNULL(T.IsElevator, 0) = 1 
                                          THEN T.Basis ELSE 0 END * T.Bushels) /                                                     
                                               CASE WHEN SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 OR ISNULL(T.IsElevator, 0) = 1 THEN T.Bushels ELSE 0 END) = 0 
                                                 THEN 1 
                                                 ELSE SUM(CASE WHEN ISNULL(T.IsProducer, 0) = 1 OR ISNULL(T.IsElevator, 0) = 1 THEN T.Bushels ELSE 0 END) 
                                               END
           END
       END, 0) AS Value
FROM (
          SELECT 'Producer' AS DeliveryType, 1 AS DeliveryTypeOrder
          UNION SELECT 'Elevator' AS DeliveryType, 2 AS DeliveryTypeOrder                       
          UNION SELECT 'NBE' AS DeliveryType, 3 AS DeliveryTypeOrder
          UNION SELECT 'Contingent' AS DeliveryType, 4 AS DeliveryTypeOrder
          UNION SELECT 'Total' AS DeliveryType, 5 AS DeliveryTypeOrder
     ) AS DT -- Table of delivery types
CROSS JOIN (
              SELECT 'Contracted Bushels' AS BasisType, 1 AS BasisTypeOrder
              UNION SELECT 'Basis' AS BasisType, 2 AS BasisTypeOrder
           ) AS BT --Table of basis types
CROSS JOIN (
              SELECT @CropYear - 1 as CropYear, cast(@CropYear - 1 as varchar) + '-' + cast(@CropYear as varchar) AS CropYearName
              UNION SELECT @CropYear as CropYear, cast(@CropYear as varchar) + '-' + cast(@CropYear + 1 as varchar)
              UNION SELECT @CropYear + 1 as CropYear, cast(@CropYear + 1 as varchar) + '-' + cast(@CropYear + 2 as varchar)
              UNION SELECT @CropYear + 2 as CropYear, cast(@CropYear + 2 as varchar) + '-' + cast(@CropYear + 3 as varchar)
              UNION SELECT @CropYear + 3 as CropYear, cast(@CropYear + 3 as varchar) + '-' + cast(@CropYear + 4 as varchar)
              UNION SELECT @CropYear + 4 as CropYear, cast(@CropYear + 4 as varchar) + '-' + cast(@CropYear + 5 as varchar)
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
(    SELECT  month(C.DueDateFrom) AS DeliveryMonth, 
       CASE WHEN month(C.DueDateFrom) >= 10 
         THEN year(C.DueDateFrom) 
         ELSE year(C.DueDateFrom) - 1 
       END AS CropYear,
     CASE WHEN NOT(C.FuturesBasis IS NULL AND C.PricedBasis IS NULL)
          AND ISNULL(CP.Elevator, 0) = 1
       THEN 1 ELSE 0 END AS IsElevator,
     CASE WHEN NOT(C.FuturesBasis IS NULL AND C.PricedBasis IS NULL)
          AND ISNULL(CP.Elevator, 0) = 0
       THEN 1 ELSE 0 END AS IsProducer,

     CASE WHEN (C.FuturesBasis IS NULL AND C.PricedBasis IS NULL)
          AND CT.ContractTypeID IN (@MNContingentOfferContractTypeID, @IAContingentOfferContractTypeID, @IACreditSaleContractTypeID)
       THEN 1 ELSE 0 END AS IsContingent,

     CASE WHEN (C.FuturesBasis IS NULL AND C.PricedBasis IS NULL)
          AND CT.ContractTypeID NOT IN (@MNContingentOfferContractTypeID, @IAContingentOfferContractTypeID, @IACreditSaleContractTypeID)
       THEN 1 ELSE 0 END AS IsNBE,

     CASE WHEN C.SubsequenceNumber IS NOT NULL THEN C.Bushels
       ELSE C.Bushels - dbo.cffn_GET_SUM_CHILD_BUSHELS(C.SequenceNumber, C.FeedMillID)
     END AS Bushels,

     ISNULL(C.FuturesBasis, C.PricedBasis) AS Basis
     FROM dbo.cft_CONTRACT C
       INNER JOIN dbo.cft_CORN_PRODUCER CP ON C.CornProducerID = CP.CornProducerID
       INNER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
     WHERE C.CommodityID = @CommodityID 
           AND C.FeedMillID LIKE @FeedMillID 
           AND C.CornProducerID LIKE @CornProducerID
           AND CT.ContractTypeID <> @MNPriceLaterContractTypeID
           AND C.ContractStatusID <> 3
           

) AS T ON T.DeliveryMonth = DM.DeliveryMonth AND T.CropYear = CY.CropYear
GROUP BY DeliveryMonthName,DeliveryMonthOrder,DeliveryType,DeliveryTypeOrder,CropYearName,BasisType,BasisTypeOrder
ORDER BY DeliveryMonthOrder,DeliveryTypeOrder,CropYearName,BasisTypeOrder   

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CONTRACTED_BUSHELS_BASIS] TO [db_sp_exec]
    AS [dbo];

