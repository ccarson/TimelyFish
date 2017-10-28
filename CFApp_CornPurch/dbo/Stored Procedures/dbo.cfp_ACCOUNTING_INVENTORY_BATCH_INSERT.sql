-- =======================================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/25/2008
-- Description:	Inserts an accounting inventory record into the cft_INVENTORY_BATCH table
-- =======================================================================================
CREATE PROCEDURE dbo.cfp_ACCOUNTING_INVENTORY_BATCH_INSERT
(	
		@PartialTicketID					int
		,@TicketNumber						varchar(20)
		,@InventoryBatchNumber				varchar(10)
		,@GeneralLedgerBatchNumber			varchar(10)
		,@StandardPrice						decimal (10,4)
		,@ValuePrice						decimal (10,4)
		,@CornClearingAmount				decimal (10,4)
		,@InventoryAmount					decimal (10,4)
		,@MarketVarianceAmount				decimal (10,4)
		,@CreatedBy							varchar(50)
)
AS
BEGIN
INSERT INTO dbo.cft_INVENTORY_BATCH
(
		PartialTicketID
		,TicketNumber
		,InventoryBatchNumber
		,GeneralLedgerBatchNumber
		,StandardPrice
		,ValuePrice
		,CornClearingAmount
		,InventoryAmount
		,MarketVarianceAmount
		,CreatedBy
)
VALUES
(
		@PartialTicketID
		,@TicketNumber
		,@InventoryBatchNumber
		,@GeneralLedgerBatchNumber
		,@StandardPrice
		,@ValuePrice
		,@CornClearingAmount
		,@InventoryAmount
		,@MarketVarianceAmount
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ACCOUNTING_INVENTORY_BATCH_INSERT] TO [db_sp_exec]
    AS [dbo];

