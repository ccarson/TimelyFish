-- ====================================================
-- Author:		Brian Cesafsky
-- Create date: 04/28/2008
-- Description:	Returns all farms for a corn producer
-- ====================================================
CREATE PROCEDURE [dbo].[cfp_STORAGE_SELECT_BY_ID]
(
	@ContactID		int
	,@Active		bit
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT Storage.StorageID
	    ,Storage.ContactID
	    ,Storage.StorageTypeID
		,Storage.Active
		,Storage.Name
		,Storage.Capacity
		,Storage.AugerID
FROM dbo.cft_STORAGE Storage (NOLOCK)
WHERE Storage.ContactID = @ContactID
AND Storage.Active = @Active
ORDER BY Storage.StorageTypeID, Storage.Name
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_STORAGE_SELECT_BY_ID] TO [db_sp_exec]
    AS [dbo];

