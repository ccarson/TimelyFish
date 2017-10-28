-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 06/12/2008
-- Description:	Updates a record in cft_STORAGE
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_STORAGE_UPDATE]
(
		@StorageID					int
		,@StorageTypeID				int
		,@Active					bit
		,@Name						varchar(100)
		,@Capacity					int
		,@AugerID					int
		,@UpdatedBy					varchar(50)
)
AS
BEGIN

UPDATE dbo.cft_STORAGE
   SET [StorageTypeID] = @StorageTypeID
		,[Active] = @Active
		,[Name] = @Name
		,[Capacity] = @Capacity
		,[AugerID] = @AugerID
		,[UpdatedBy] = @UpdatedBy
 WHERE 
	[StorageID] = @StorageID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_STORAGE_UPDATE] TO [db_sp_exec]
    AS [dbo];

