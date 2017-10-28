-- =========================================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/20/2008
-- Description:	Returns a list of partial tickets by date range
--              that have NOT been sent to Inventory
-- =========================================================================================
CREATE PROCEDURE [dbo].[cfp_PARTIAL_TICKET_BY_DATE_RANGE_SELECT]
(
	@FromDate				datetime
	,@ToDate				datetime
	,@FeedMillID			char(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PT.PartialTicketID
		,PT.PartialTicketStatusID
		,PT.TicketNumber
		,PT.FullTicketID
		,PT.ContractID
		,PT.CornProducerID
		,PT.DeliveryCornProducerID
		,PT.DeliveryDate
		,PT.DryBushels
		,PT.MoistureRateAdj
		,PT.ForeignMaterialRateAdj
		,PT.TestWeightRateAdj
		,PT.DryingRateAdj
		,PT.HandlingRateAdj
		,PT.DeferredPaymentRateAdj
		,PT.MiscAdj
		,PT.MiscAdjNote
		,PT.TicketAdjNote
		,PT.ContractAdjustmentRate
		,PT.PaymentTypeID
		,PT.QuoteID
		,PT.PaymentTermsID
		,PT.ReadyToBeReleased
		,PT.SentToInventory
		,PT.SentToAccountsPayable
		,PT.WetBushels
		,C.ContractNumber
		,CT.Name AS ContractTypeName
		FROM dbo.cft_PARTIAL_TICKET PT
			LEFT OUTER JOIN dbo.cft_CONTRACT C ON PT.ContractID = C.ContractID
			LEFT OUTER JOIN dbo.cft_CONTRACT_TYPE CT ON CT.ContractTypeID = C.ContractTypeID
			INNER JOIN dbo.cft_CORN_TICKET FT ON FT.TicketID = PT.FullTicketID	
		WHERE PT.SentToInventory = 0
			AND PT.DeliveryDate between @FromDate and @ToDate
			AND FT.FeedMillID = @FeedMillID


--WHERE CT.FeedMillID = @FeedMillID AND NOT(	PT.PaymentTypeID IN (3,4) 
--                 						OR PT.ContractID IS NOT NULL AND C.DeferredPaymentDate IS NOT NULL AND DATEDIFF(day,C.DeferredPaymentDate,getdate()) > 0 
--                 						OR PT.ContractID IS NOT NULL AND ISNULL(C.Cash,0) = 0 
--                 						OR ((PT.PaymentTypeID = 2) AND (PT.ContractID IS NULL)))

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PARTIAL_TICKET_BY_DATE_RANGE_SELECT] TO [db_sp_exec]
    AS [dbo];

