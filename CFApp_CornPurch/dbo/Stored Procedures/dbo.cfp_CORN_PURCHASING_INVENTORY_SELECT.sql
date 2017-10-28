-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 08/10/2008
-- Description:	Returns Inventory records
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_INVENTORY_SELECT]
(
	@FeedMillID		varchar(10)
	,@CommodityID	int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT TOP 365 InventoryID
		,FeedMillID
		,CommodityID
		,InventoryDate
		,Adjustments
		,Balance
		,DailyReceived
		,DailyUsage
		,CreatedDateTime
		,CreatedBy
		,UpdatedDateTime
		,UpdatedBy
FROM dbo.cft_CORN_PURCHASING_INVENTORY
WHERE FeedMillID = @FeedMillID
AND CommodityID = @CommodityID
ORDER BY InventoryDate desc
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_INVENTORY_SELECT] TO [db_sp_exec]
    AS [dbo];

