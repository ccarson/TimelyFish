-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 04/27/2009
-- Description:	Deletes an Iodine Value record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_IODINE_VALUE_DELETE]
(
	@IodineID [int] 
)
AS
BEGIN
	DELETE from dbo.cft_IODINE_VALUE 
	WHERE [IodineID] = @IodineID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_IODINE_VALUE_DELETE] TO [db_sp_exec]
    AS [dbo];

