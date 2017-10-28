

-- ===================================================================
-- Author:  Sergey Neskin
-- Create date: 08/05/2008
-- Description: Selects data for Price Later/Credit Sale Contract report
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_PRICE_LATER_V1]
(
	@FeedMillID varchar(30),
	@CornProducerID varchar(15) = NULL,
	@ComparisonOperator int,
	@PriceOutDate datetime
)
AS
BEGIN
SET NOCOUNT ON;

SELECT 
	FM.Name AS FeedMillName,
	PT.CornProducerID AS CornProducerID,
	PT.TicketNumber AS TicketNumber,
	V.RemitName AS CornProducerName,
	C.ContractNumber AS ContractNumber,
	ct.Name,
	ct.PriceLater,
	gh.HandlingCharge*12.0/365.0 * (case when datediff(d,pt.DeliveryDate,getdate())-FreeDelayedPricingLength < 0 then 0 else (datediff(d,pt.DeliveryDate,getdate())-FreeDelayedPricingLength) end) * -1.0 * pt.DryBushels as [Accumulated Handling Charge],
	c.DueDateFrom,
	c.DueDateTo,
	c.Bushels as C_Bushels,
	PT.DryBushels AS PT_Bushels,
	PT.DeliveryDate AS DeliveryDate,
	c.SettlementDate as LastPricingDate

FROM cft_PARTIAL_TICKET PT   
	INNER JOIN cft_CONTRACT C ON C.ContractID = PT.ContractID
	INNER JOIN cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
	INNER JOIN cft_FEED_MILL FM ON FM.FeedMillID = C.FeedMillID
	INNER JOIN [$(SolomonApp)].dbo.Vendor V ON V.VendId = ISNULL(PT.DeliveryCornProducerID, PT.CornProducerID)
	inner join cft_GPA_HANDLING_CHARGE GH on GH.FeedMillID=c.FeedMillID
	       and pt.DeliveryDate between gh.EffectiveDateFrom and ISNULL(gh.EffectiveDateTo,getdate())

WHERE C.FeedMillID = @FeedMillID
	  AND ((@CornProducerID IS NULL) OR (V.VendId LIKE @CornProducerID))
	  AND (    
		    ((@ComparisonOperator = 0) AND (@PriceOutDate = (PT.DeliveryDate + 364))) OR 
		    ((@ComparisonOperator = -1) AND (@PriceOutDate > (PT.DeliveryDate + 364))) OR
		    ((@ComparisonOperator = 1) AND (@PriceOutDate < (PT.DeliveryDate + 364)))
              )
          AND CT.PriceLater = 1
          AND ISNULL(PT.SentToAccountsPayable, 0) = 0
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_PRICE_LATER_V1] TO [db_sp_exec]
    AS [dbo];

