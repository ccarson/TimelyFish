
-- ===================================================================
-- Author:	Andrew Derco
-- Create date: 10/01/2008
-- Description:	Selects adjusted Commission details for partial ticket.
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CORN_PURCHASING_COMMISSION_SELECT_ADJUSTED_BY_PARTIAL_TICKET
(
    @PartialTicketID	int
 
)
AS
BEGIN
SET NOCOUNT ON;



SELECT LTRIM(RTRIM(M.FirstName)) + ' ' + LTRIM(RTRIM(M.MiddleInitial)) + ' ' + LTRIM(RTRIM(M.LastName)) AS Marketer,
       COM.MarketerID,
       COM.[Percent] AS MarketerPercent,
       COM.CommissionRateTypeID AS CommissionTypeID,
       CASE WHEN PR.PromotionID IS NOT NULL THEN CRD.Value ELSE
         CASE WHEN SR1.CommissionRateID IS NOT NULL THEN CRD1.Value ELSE NULL
         END
       END AS SuggestedCommissionRate,
       COM.Rate AS CommissionRate,
       PT.DryBushels * COM.Rate * COM.[Percent] / 100  AS TotalCommissionPayment,
       CAST(ISNULL(COM.Approved, 0) AS bit) AS Approved,
       PT.DryBushels * COM.[Percent] / 100 AS DryBushels,
       COMP.SoldBushels 

FROM dbo.cft_PARTIAL_TICKET PT
INNER JOIN dbo.cft_COMMISSION COM ON PT.PartialTicketID = COM.PartialTicketID
INNER JOIN dbo.cft_MARKETER M ON M.MarketerID = COM.MarketerID
INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID
LEFT OUTER JOIN dbo.cft_CONTRACT C ON C.ContractID = PT.ContractID

--sold bushels
LEFT OUTER JOIN (
                    SELECT MarketerID, SUM(MarketerDryBushels) AS SoldBushels
                    FROM dbo.cft_COMMISSION_PAYMENT
                    GROUP BY MarketerID
                ) COMP ON COMP.MarketerID = M.MarketerID   
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
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_COMMISSION_SELECT_ADJUSTED_BY_PARTIAL_TICKET] TO [db_sp_exec]
    AS [dbo];

