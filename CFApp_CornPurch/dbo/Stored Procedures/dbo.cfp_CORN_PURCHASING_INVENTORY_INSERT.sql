-- =================================================================
-- Author:		Brian Cesafsky
-- Create date: 08/01/2008
-- Description:	Inserts a record into cft_CORN_PURCHASING_INVENTORY
-- =================================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_INVENTORY_INSERT]
(
		@FeedMillID			varchar(15)
		,@CommodityID		int
		,@InventoryDate		smalldatetime
		,@Adjustments		decimal(10,2)
		,@Balance			decimal(10,2)
		,@DailyReceived		decimal(10,2)
		,@DailyUsage		decimal(10,2)
		,@CreatedBy			varchar(50)
)
AS
BEGIN
INSERT INTO [cft_CORN_PURCHASING_INVENTORY]
(
		[FeedMillID]
	   ,[CommodityID]
	   ,[InventoryDate]
	   ,[Adjustments]
	   ,[Balance]
	   ,[DailyReceived]
	   ,[DailyUsage]
	   ,[CreatedBy]
)
VALUES
(
		@FeedMillID
		,@CommodityID
		,@InventoryDate
		,@Adjustments
		,@Balance
		,@DailyReceived
		,@DailyUsage
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_INVENTORY_INSERT] TO [db_sp_exec]
    AS [dbo];

