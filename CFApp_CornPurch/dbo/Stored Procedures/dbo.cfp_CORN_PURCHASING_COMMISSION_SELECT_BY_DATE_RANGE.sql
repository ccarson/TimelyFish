
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/01/2008
-- Description:	Selects Commissions by date range
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_SELECT_BY_DATE_RANGE
(
    @DateFrom		datetime,
    @DateTo		datetime
 
)
AS
BEGIN
SET NOCOUNT ON;



SELECT PT.PartialTicketID,
       CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END AS CornProducerID,
       V.RemitName AS CornProducer,
       PT.TicketNumber,
       LTRIM(RTRIM(M.FirstName)) + ' ' + LTRIM(RTRIM(M.MiddleInitial)) + ' ' + LTRIM(RTRIM(M.LastName)) AS Marketer,
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
       END AS MarketerPercent,
       CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.CommissionRateTypeID ELSE
         CASE WHEN PR.PromotionID IS NOT NULL THEN 2 ELSE
           CASE WHEN SR1.CommissionRateID IS NOT NULL THEN 1 ELSE NULL
           END
         END
       END AS CommissionTypeID,
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
       END AS TotalCommissionPayment,
       PT.DryBushels * CASE WHEN COM.PartialTicketID IS NOT NULL THEN COM.[Percent] ELSE
                         CASE WHEN CM.MarketerID IS NOT NULL THEN CM.Value ELSE
                         CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractiD IS NULL THEN 100 ELSE NULL
                         END
                       END
       END  / 100 AS DryBushels,
       PT.DryBushels AS TicketDryBushels,
       FM.FeedMillID,
       FM.Name AS DeliveryFM,
       PT.DeliveryDate,
       C.ContractID,
       C.ContractNumber,
       ISNULL(COMP.BushelsSold,0) AS BushelsSold,
       CAST(ISNULL(COM.Approved, 0) AS bit) AS Approved,
       CAST(CASE WHEN COM.PartialTicketID IS NULL THEN 0 ELSE 1 END AS bit) AS IsAdjustment
FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
INNER JOIN dbo.cft_FEED_MILL FM ON FM.FeedMillID = FT.FeedMillID
INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END
INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = CP.CornProducerID
LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
LEFT OUTER JOIN dbo.cft_COMMISSION COM ON PT.PartialTicketID = COM.PartialTicketID
--LEFT OUTER JOIN dbo.cft_COMMISSION_DETAIL COMD ON COMD.PartialTicketID = COM.PartialTicketID
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
WHERE PT.DeliveryDate BETWEEN @DateFrom AND @DateTo AND NOT EXISTS (SELECT 1 FROM dbo.cft_COMMISSION_PAYMENT WHERE PartialTicketID = PT.PartialTicketID)
ORDER BY 2,4
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_SELECT_BY_DATE_RANGE] TO [db_sp_exec]
    AS [dbo];

