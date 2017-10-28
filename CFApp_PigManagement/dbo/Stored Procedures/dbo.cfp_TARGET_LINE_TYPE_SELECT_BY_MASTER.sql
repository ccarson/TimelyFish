-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2009
-- Description:	Selects target line types by Master Type
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_TYPE_SELECT_BY_MASTER]
(
    @TargetLineMasterTypeID	int
)
AS
BEGIN
	SELECT TargetLineTypeID
		   ,TargetLineTypeDescription
		   ,CreatedDateTime
		   ,CreatedBy
		   ,UpdatedDateTime
		   ,UpdatedBy
	FROM dbo.cft_TARGET_LINE_TYPE  (NOLOCK)
	WHERE TargetLineMasterTypeID = @TargetLineMasterTypeID
	ORDER BY TargetLineTypeDescription asc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_TYPE_SELECT_BY_MASTER] TO [db_sp_exec]
    AS [dbo];

