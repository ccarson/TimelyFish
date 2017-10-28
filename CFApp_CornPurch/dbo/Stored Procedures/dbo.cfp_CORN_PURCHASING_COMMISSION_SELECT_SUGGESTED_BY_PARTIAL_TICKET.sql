
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/01/2008
-- Description:	Selects suggested Commission details for partial ticket.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_SELECT_SUGGESTED_BY_PARTIAL_TICKET
(
    @PartialTicketID	int
 
)
AS
BEGIN
SET NOCOUNT ON;



SELECT LTRIM(RTRIM(M.FirstName)) + ' ' + LTRIM(RTRIM(M.MiddleInitial)) + ' ' + LTRIM(RTRIM(M.LastName)) AS Marketer,
       CASE WHEN CM.MarketerID IS NOT NULL THEN CM.MarketerID ELSE 
        CASE WHEN PT.ContractID IS NULL THEN
         CP.DefaultCornMarketerID ELSE NULL END
       END AS MarketerID,
       CASE WHEN CM.MarketerID IS NOT NULL THEN CM.Value ELSE
         CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractID IS NULL THEN 100 ELSE NULL
         END
       END AS MarketerPercent,
       CASE WHEN PR.PromotionID IS NOT NULL THEN 2 ELSE
         CASE WHEN SR1.CommissionRateID IS NOT NULL THEN 1 ELSE NULL
         END
       END AS CommissionTypeID,
       CASE WHEN PR.PromotionID IS NOT NULL THEN CRD.Value ELSE
         CASE WHEN SR1.CommissionRateID IS NOT NULL THEN CRD1.Value ELSE NULL
         END
       END AS CommissionRate,
       CASE WHEN PR.PromotionID IS NOT NULL THEN CRD.Value ELSE
         CASE WHEN SR1.CommissionRateID IS NOT NULL THEN CRD1.Value ELSE NULL
         END
       END AS SuggestedCommissionRate,
       CASE WHEN PR.PromotionID IS NOT NULL THEN CASE WHEN CM.MarketerID IS NOT NULL THEN PT.DryBushels * CRD.Value * CM.Value / 100 ELSE
                                                   CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractID IS NULL THEN PT.DryBushels * CRD.Value * 100 / 100 ELSE NULL 
                                                   END 
                                                   END ELSE
         CASE WHEN SR1.CommissionRateID IS NOT NULL THEN CASE WHEN CM.MarketerID IS NOT NULL THEN PT.DryBushels * CRD1.Value * CM.Value / 100 ELSE
                                                      CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractID IS NULL THEN PT.DryBushels * CRD1.Value * 100 / 100 ELSE NULL 
                                                      END 
                                                    END
         END
       END AS TotalCommissionPayment,
       CAST(0 AS bit) AS Approved,
       PT.DryBushels * CASE WHEN CM.MarketerID IS NOT NULL THEN CM.Value ELSE
                         CASE WHEN CP.DefaultCornMarketerID IS NOT NULL AND PT.ContractID IS NULL THEN 100 ELSE NULL
                         END
                       END / 100 AS DryBushels,
       COMP.SoldBushels

FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN dbo.cft_CORN_PRODUCER CP ON CP.CornProducerID = CASE WHEN PT.ContractID IS NOT NULL THEN PT.CornProducerID ELSE ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID) END
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID
LEFT OUTER JOIN dbo.cft_CONTRACT_MARKETER CM ON CM.ContractID = PT.ContractID
--marketer
LEFT OUTER JOIN dbo.cft_MARKETER M ON M.MarketerID = CASE WHEN CM.MarketerID IS NOT NULL THEN CM.MarketerID ELSE
                                                       CASE WHEN PT.ContractID IS NULL THEN CP.DefaultCornMarketerID ELSE NULL
                                                       END
                                                     END
--sold bushels
LEFT OUTER JOIN (
                    SELECT MarketerID, SUM(MarketerDryBushels) AS SoldBushels
                    FROM dbo.cft_COMMISSION_PAYMENT
                    GROUP BY MarketerID
                ) COMP ON COMP.MarketerID = M.MarketerID   
--promotion
LEFT OUTER JOIN dbo.cft_PROMOTION_RATE PR ON PT.ContractID IS NOT NULL 
                                             AND FT.FeedMillID = PR.FeedMillID
                                             AND PR.Active = 1
                                             AND C.DateEstablished BETWEEN PR.DateEstablishedFrom AND PR.DateEstablishedTo
                                             AND PT.DeliveryDate BETWEEN PR.DeliveryDateFrom AND PR.DeliveryDateTo
LEFT OUTER JOIN dbo.cft_STANDARD_RATE SR ON PR.PromotionID = SR.PromotionID
                                            AND SR.Active = 1
                                            AND PT.DeliveryDate BETWEEN SR.EffectiveDateFrom AND ISNULL(SR.EffectiveDateTo, '12/31/9999')
LEFT OUTER JOIN dbo.cft_COMMISSION_RATE_DETAIL CRD ON SR.CommissionRateID = CRD.CommissionRateID
                                                      AND ISNULL(COMP.SoldBushels, 0) BETWEEN CRD.RangeFrom AND CRD.RangeTo
--standard
LEFT OUTER JOIN dbo.cft_STANDARD_RATE SR1 ON PR.PromotionID IS NULL --there are no promotions
                                             AND SR1.PromotionID IS NULL
                                             AND FT.FeedMillID = SR1.FeedMillID
                                             AND SR1.Active = 1
                                             AND PT.DeliveryDate BETWEEN SR1.EffectiveDateFrom AND ISNULL(SR1.EffectiveDateTo, '12/31/9999')
LEFT OUTER JOIN dbo.cft_COMMISSION_RATE_DETAIL CRD1 ON SR1.CommissionRateID = CRD1.CommissionRateID
                                                      AND ISNULL(COMP.SoldBushels, 0) BETWEEN CRD1.RangeFrom AND CRD1.RangeTo
WHERE PT.PartialTicketID = @PartialTicketID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_SELECT_SUGGESTED_BY_PARTIAL_TICKET] TO [db_sp_exec]
    AS [dbo];

