-- ====================================================
-- Author:		Brian Cesafsky
-- Create date: 04/28/2008
-- Description:	Returns all storage types
-- ====================================================
CREATE PROCEDURE [dbo].[cfp_STORAGE_TYPE_SELECT]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT StorageTypeID
	    ,Description
FROM dbo.cft_STORAGE_TYPE (NOLOCK)
ORDER BY Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_STORAGE_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

