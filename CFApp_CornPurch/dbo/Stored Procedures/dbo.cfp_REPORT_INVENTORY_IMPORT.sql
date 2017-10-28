
-- =============================================
-- Author:		Matt Dawson
-- Create date: 08/29/2008
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_INVENTORY_IMPORT]
(	
	@BatchNumber VARCHAR(10)
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT
	cft_INVENTORY_BATCH.InventoryBatchID
,	cft_INVENTORY_BATCH.InventoryBatchNumber
,	cft_CORN_TICKET.TicketNumber
,	cft_FEED_MILL.Name 'FeedMill'
,	cft_GL.ExpenseAccount
,	Vendor.Name 'CornProducer'
,	Contract.ContractNumber
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101) 'DeliveryDate'
,	RTRIM(cft_CORN_TICKET.Commodity) 'Commodity'
,	COALESCE(SUM(cft_INVENTORY_BATCH.InventoryAmount),0) 'SumDryBushels'
,	SUM(cft_INVENTORY_BATCH.ValuePrice) 'ValuePrice'
,	CAST(COALESCE(SUM(cft_INVENTORY_BATCH.InventoryAmount),0) * SUM(cft_INVENTORY_BATCH.ValuePrice) AS NUMERIC(18,2)) 'TotalValue'
,	SUM(cft_INVENTORY_BATCH.StandardPrice) 'StandardCost'
,	CAST(COALESCE(SUM(cft_INVENTORY_BATCH.InventoryAmount),0) * SUM(cft_INVENTORY_BATCH.StandardPrice) AS NUMERIC(18,2)) 'StandardValue'
FROM		dbo.cft_CORN_TICKET cft_CORN_TICKET (NOLOCK)
LEFT OUTER JOIN dbo.cft_FEED_MILL cft_FEED_MILL (NOLOCK)
	ON cft_FEED_MILL.FeedMillID = cft_CORN_TICKET.FeedMillID
INNER JOIN dbo.cft_INVENTORY_BATCH cft_INVENTORY_BATCH (NOLOCK)
	ON cft_INVENTORY_BATCH.TicketNumber = cft_CORN_TICKET.TicketNumber
LEFT OUTER JOIN dbo.cft_PARTIAL_TICKET cft_PARTIAL_TICKET (NOLOCK)
	ON cft_INVENTORY_BATCH.PartialTicketID = cft_PARTIAL_TICKET.PartialTicketID
LEFT OUTER JOIN	dbo.cft_CORN_PRODUCER cft_CORN_PRODUCER (NOLOCK)
	ON	RTRIM(cft_CORN_PRODUCER.CornProducerID) = RTRIM(cft_PARTIAL_TICKET.CornProducerID)
LEFT OUTER JOIN dbo.cft_Vendor Vendor (NOLOCK)
	ON	RTRIM(Vendor.VendID) = RTRIM(cft_CORN_PRODUCER.CornProducerID)
LEFT OUTER JOIN dbo.cft_Contract Contract (NOLOCK)
	ON Contract.ContractID = cft_PARTIAL_TICKET.ContractID
LEFT OUTER JOIN cft_GL cft_GL (NOLOCK)
	ON cft_GL.FeedMillID = cft_FEED_MILL.FeedMillID
	AND cft_GL.GLTypeID = 11 --CORN CLEARING ACCOUNT
WHERE	cft_INVENTORY_BATCH.InventoryBatchNumber = @BatchNumber
GROUP BY
	cft_INVENTORY_BATCH.InventoryBatchID
,	cft_INVENTORY_BATCH.InventoryBatchNumber
,	cft_CORN_TICKET.TicketNumber
,	cft_FEED_MILL.Name
,	cft_GL.ExpenseAccount
,	Vendor.Name
,	Contract.ContractNumber
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)
,	RTRIM(cft_CORN_TICKET.Commodity)
ORDER BY
	cft_FEED_MILL.Name
,	Vendor.Name
,	RTRIM(cft_CORN_TICKET.Commodity)
,	CONVERT(VARCHAR,cft_CORN_TICKET.DeliveryDate,101)	--cft_CORN_TICKET.DeliveryDate	-- 20140925 smr change required after the change to compat 100 and the sp2 upgrade

END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_INVENTORY_IMPORT] TO [db_sp_exec]
    AS [dbo];

