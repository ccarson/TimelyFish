-- ===============================================================
-- Author:		Brian Cesafsky
-- Create date: 08/01/2008
-- Description:	Updates a record in cft_CORN_PURCHASING_INVENTORY
-- ===============================================================
CREATE PROCEDURE [dbo].[cfp_CORN_PURCHASING_INVENTORY_UPDATE]
(
		@InventoryID				int
		,@Adjustments				decimal(10,2)
		,@Balance					decimal(10,2)
		,@DailyReceived				decimal(10,2)
		,@DailyUsage				decimal(10,2)
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_CORN_PURCHASING_INVENTORY
   SET [Adjustments] = @Adjustments
		,[Balance] = @Balance
		,[DailyReceived] = @DailyReceived
		,[DailyUsage] = @DailyUsage
		,[UpdatedBy] = @UpdatedBy

 WHERE 
	[InventoryID] = @InventoryID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CORN_PURCHASING_INVENTORY_UPDATE] TO [db_sp_exec]
    AS [dbo];

