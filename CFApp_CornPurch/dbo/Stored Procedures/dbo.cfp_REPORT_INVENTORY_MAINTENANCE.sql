-- =============================================
-- Author:		Andrey Derco
-- Create date: 11/17/2008
-- Description:	 Select data for Inventory Maintenance report
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_INVENTORY_MAINTENANCE]
(	
	@FeedMillID	varchar(10),
	@CommodityID	int,
	@Date		datetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT TOP 31 InventoryID
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
WHERE FeedMillID = @FeedMillID AND InventoryDate <= @Date
AND CommodityID = @CommodityID
ORDER BY InventoryDate DESC



END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_INVENTORY_MAINTENANCE] TO [db_sp_exec]
    AS [dbo];

