-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 06/12/2008
-- Description:	Inserts a record into dbo.cft_STORAGE
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_STORAGE_INSERT]
(
		@ContactID				int
		,@StorageTypeID			int
		,@Active				bit
		,@Name					varchar(100)
		,@Capacity				int
		,@AugerID				int
		,@CreatedBy				varchar(50)
)
AS
BEGIN
INSERT INTO [cft_STORAGE]
(
	   [ContactID]
		,[StorageTypeID]
		,[Active]
		,[Name]
		,[Capacity]
		,[AugerID]
		,[CreatedBy]
)
VALUES
(
		@ContactID
		,@StorageTypeID
		,@Active
		,@Name
		,@Capacity
		,@AugerID
		,@CreatedBy
)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_STORAGE_INSERT] TO [db_sp_exec]
    AS [dbo];

