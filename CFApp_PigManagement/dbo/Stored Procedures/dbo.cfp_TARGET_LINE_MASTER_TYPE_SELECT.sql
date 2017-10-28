-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2009
-- Description:	Returns all Master Type Target Lines
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_MASTER_TYPE_SELECT]
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TargetLineMasterTypeID
		, TargetLineMasterTypeDescription
	FROM dbo.cft_TARGET_LINE_MASTER_TYPE (NOLOCK)
	ORDER BY TargetLineMasterTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_MASTER_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

