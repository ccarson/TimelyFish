-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 12/30/2009
-- Description:	Selects target line values by Master Type
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_VALUES_SELECT_BY_MASTER]
(
    @TargetLineMasterTypeID	int
)
AS
BEGIN
	SELECT cft_TARGET_LINE_TYPE.TargetLineTypeID
		  ,cft_TARGET_LINE_TYPE.TargetLineTypeDescription
		  ,cft_TARGET_LINE.TargetLineID
		  ,cft_TARGET_LINE.TargetLineValue
	FROM dbo.cft_TARGET_LINE_TYPE cft_TARGET_LINE_TYPE  (NOLOCK)
	LEFT JOIN dbo.cft_TARGET_LINE cft_TARGET_LINE (NOLOCK)
		ON cft_TARGET_LINE.TargetLineTypeID=cft_TARGET_LINE_TYPE.TargetLineTypeID 
	WHERE cft_TARGET_LINE_TYPE.TargetLineMasterTypeID = @TargetLineMasterTypeID
	ORDER BY cft_TARGET_LINE_TYPE.TargetLineTypeDescription asc
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_VALUES_SELECT_BY_MASTER] TO [db_sp_exec]
    AS [dbo];

