-- ======================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/13/2008
-- Description:	Returns an inventory batch record by ID
-- ======================================================================
CREATE PROCEDURE [dbo].[cfp_ACCOUNTING_INVENTORY_BATCH_SELECT_BY_ID]
(
	@PartialTicketID		int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT PartialTicketID
		,TicketNumber
		,InventoryBatchNumber
		,GeneralLedgerBatchNumber
		,StandardPrice
		,ValuePrice
		,CornClearingAmount
		,InventoryAmount
		,MarketVarianceAmount
FROM dbo.cft_INVENTORY_BATCH
WHERE PartialTicketID = @PartialTicketID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ACCOUNTING_INVENTORY_BATCH_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

