
-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 08/05/2008
-- Description: Selects data for Report Commissions Payment report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_COMMISSIONS_PAYMENT]
(
	@MarketerID tinyint,
	@StartDate datetime,
	@EndDate datetime
)
AS
BEGIN
SET NOCOUNT ON;

IF EXISTS (SELECT 1 FROM dbo.cft_COMMISSION_TEMP) BEGIN

SELECT DATA.*, 
       @StartDate AS StartDate,
       @EndDate AS EndDate
FROM
(
SELECT PT.PartialTicketID,
       CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END AS CornProducerID,
       V.RemitName AS CornProducerName,
       PT.TicketNumber,
       LTRIM(RTRIM(M.FirstName)) + ' ' + LTRIM(RTRIM(M.MiddleInitial)) + ' ' + LTRIM(RTRIM(M.LastName)) AS MarketerName,
       M.EmployeeID,
       CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.MarketerID ELSE
         CASE WHEN CM.MarketerID IS NOT NULL THEN CM.MarketerID ELSE
           CASE WHEN PT.ContractID IS NULL THEN
           CP.DefaultCornMarketerID ELSE NULL END
         END
       END AS MarketerID,
       CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.[Percent] ELSE
         CASE WHEN CM.MarketerID IS NOT NULL THEN CM.Value ELSE
           CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractiD IS NULL THEN 100 ELSE NULL
           END
         END
       END AS MarketerValue,
       CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.CommissionRateTypeID ELSE
         CASE WHEN PR.PromotionID IS NOT NULL THEN 2 ELSE
           CASE WHEN SR1.CommissionRateID IS NOT NULL THEN 1 ELSE NULL
           END
         END
       END AS RateType,
       CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.Rate ELSE
         CASE WHEN PR.PromotionID IS NOT NULL THEN CRD.Value ELSE
           CASE WHEN SR1.CommissionRateID IS NOT NULL THEN CRD1.Value ELSE NULL
           END
         END
       END AS CommissionRate,
       CASE WHEN COM.PartialTicketID IS NOT NULL THEN PT.DryBushels * COM.Rate * COM.[Percent] / 100 ELSE
         CASE WHEN PR.PromotionID IS NOT NULL THEN CASE WHEN CM.MarketerID IS NOT NULL THEN PT.DryBushels * CRD.Value * CM.Value / 100 ELSE
                                                     CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractID IS NULL THEN PT.DryBushels * CRD.Value * 100 / 100 ELSE NULL 
                                                     END 
                                                   END ELSE
           CASE WHEN SR1.CommissionRateID IS NOT NULL THEN CASE WHEN CM.MarketerID IS NOT NULL THEN PT.DryBushels * CRD1.Value * CM.Value / 100 ELSE
                                                        CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractID IS NULL THEN PT.DryBushels * CRD1.Value * 100 / 100 ELSE NULL 
                                                        END 
                                                      END
           END
         END
       END AS CommissionPayment,                   
       PT.DryBushels,
       FM.FeedMillID,
       FM.Name AS FeedMillName,
       PT.DeliveryDate,
       C.ContractNumber
FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
LEFT OUTER JOIN dbo.cft_COMMISSION COM ON PT.PartialTicketID = COM.PartialTicketID
LEFT OUTER JOIN dbo.cft_CONTRACT_MARKETER CM ON CM.ContractID = PT.ContractID AND COM.PartialTicketID IS NULL --there are no adjustments for ticket
--marketer
LEFT OUTER JOIN dbo.cft_MARKETER M ON M.MarketerID = CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.MarketerID ELSE
                                                       CASE WHEN CM.MarketerID IS NOT NULL THEN CM.MarketerID ELSE
                                                         CASE WHEN PT.ContractID IS NULL THEN CP.DefaultCornMarketerID ELSE NULL
                                                         END
                                                       END
                                                     END
--sold bushels
LEFT OUTER JOIN (
                    SELECT MarketerID, SUM(MarketerDryBushels) AS BushelsSold
                    FROM dbo.cft_COMMISSION_PAYMENT
                    GROUP BY MarketerID
                ) COMP ON COMP.MarketerID = M.MarketerID   
--promotion
LEFT OUTER JOIN dbo.cft_PROMOTION_RATE PR ON COM.PartialTicketID IS NULL --there are no adustments
                                             AND PT.ContractID IS NOT NULL 
                                             AND FT.FeedMillID = PR.FeedMillID
                                             AND PR.Active = 1
                                             AND C.DateEstablished BETWEEN PR.DateEstablishedFrom AND PR.DateEstablishedTo
                                             AND PT.DeliveryDate BETWEEN PR.DeliveryDateFrom AND PR.DeliveryDateTo
LEFT OUTER JOIN dbo.cft_STANDARD_RATE SR ON PR.PromotionID = SR.PromotionID
                                            AND SR.Active = 1
                                            AND PT.DeliveryDate BETWEEN SR.EffectiveDateFrom AND ISNULL(SR.EffectiveDateTo, '12/31/9999')
LEFT OUTER JOIN dbo.cft_COMMISSION_RATE_DETAIL CRD ON SR.CommissionRateID = CRD.CommissionRateID
                                                      AND ISNULL(COMP.BushelsSold, 0) BETWEEN CRD.RangeFrom AND CRD.RangeTo
--standard
LEFT OUTER JOIN dbo.cft_STANDARD_RATE SR1 ON COM.PartialTicketID IS NULL --there are no adustments
                                             AND PR.PromotionID IS NULL --there are no promotions
                                             AND SR1.PromotionID IS NULL
                                             AND FT.FeedMillID = SR1.FeedMillID
                                             AND SR1.Active = 1
                                             AND PT.DeliveryDate BETWEEN SR1.EffectiveDateFrom AND ISNULL(SR1.EffectiveDateTo, '12/31/9999')
LEFT OUTER JOIN dbo.cft_COMMISSION_RATE_DETAIL CRD1 ON SR1.CommissionRateID = CRD1.CommissionRateID
                                                      AND ISNULL(COMP.BushelsSold, 0) BETWEEN CRD1.RangeFrom AND CRD1.RangeTo
) AS DATA
LEFT OUTER JOIN dbo.cft_COMMISSION_TEMP COMT ON COMT.PartialTicketID = DATA.PartialTicketID AND COMT.MarketerID = DATA.MarketerID
WHERE DATA.DeliveryDate BETWEEN @StartDate AND @EndDate 
      AND DATA.RateType IS NOT NULL
      AND (ISNULL(@MarketerID, 0) = 0 AND DATA.MarketerID IS NOT NULL OR ISNULL(DATA.MarketerID, -1) = @MarketerID)
      AND ((NOT EXISTS(SELECT 1 FROM dbo.cft_COMMISSION_TEMP)) OR (COMT.PartialTicketID IS NOT NULL AND COMT.MarketerID IS NOT NULL))
ORDER BY DATA.TicketNumber 

DELETE dbo.cft_COMMISSION_TEMP

END ELSE BEGIN

SELECT DATA.*, 
       @StartDate AS StartDate,
       @EndDate AS EndDate
FROM
(
SELECT PT.PartialTicketID,
       CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END AS CornProducerID,
       V.RemitName AS CornProducerName,
       PT.TicketNumber,
       LTRIM(RTRIM(M.FirstName)) + ' ' + LTRIM(RTRIM(M.MiddleInitial)) + ' ' + LTRIM(RTRIM(M.LastName)) AS MarketerName,
       M.EmployeeID,
       COM.MarketerID,
       COM.[Percent] AS MarketerValue,
       COM.CommissionRateTypeID AS RateType,
       COM.Rate AS CommissionRate,
       PT.DryBushels * COM.Rate * COM.[Percent] / 100 AS CommissionPayment,                   
       PT.DryBushels,
       FM.FeedMillID,
       FM.Name AS FeedMillName,
       PT.DeliveryDate,
       C.ContractNumber,
       COM.Approved
FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
INNER JOIN dbo.cft_COMMISSION COM ON PT.PartialTicketID = COM.PartialTicketID
INNER JOIN dbo.cft_MARKETER M ON M.MarketerID = COM.MarketerID 
LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID

) AS DATA

WHERE DATA.DeliveryDate BETWEEN @StartDate AND @EndDate 
      AND DATA.RateType IS NOT NULL
      AND (ISNULL(@MarketerID, 0) = 0 AND DATA.MarketerID IS NOT NULL OR ISNULL(DATA.MarketerID, -1) = @MarketerID)
      AND DATA.Approved = 1
ORDER BY DATA.TicketNumber 


END
END
                            

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_COMMISSIONS_PAYMENT] TO [db_sp_exec]
    AS [dbo];

