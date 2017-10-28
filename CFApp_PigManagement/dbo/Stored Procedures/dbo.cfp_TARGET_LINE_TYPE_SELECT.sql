-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 10/15/2009
-- Description:	Selects target line types
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_TYPE_SELECT]
AS
BEGIN
	SELECT [TargetLineTypeID]
		 , [TargetLineTypeDescription]
		 , [CreatedDateTime]
		 , [CreatedBy]
		 , [UpdatedDateTime]
		 , [UpdatedBy] 
	FROM dbo.cft_TARGET_LINE_TYPE (NOLOCK)
	ORDER BY TargetLineTypeDescription asc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_TYPE_SELECT] TO [db_sp_exec]
    AS [dbo];

