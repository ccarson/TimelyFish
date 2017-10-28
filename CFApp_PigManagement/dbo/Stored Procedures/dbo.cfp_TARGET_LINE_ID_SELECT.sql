-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 11/13/2009
-- Description:	Selects target line ID
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_TARGET_LINE_ID_SELECT]
(
    @TargetLineTypeID		int
    , @PICWeek				smallint
    , @PICYear				smallint
    , @PigFlowID			int
)
AS
BEGIN
	SELECT TargetLineID
	FROM dbo.cft_TARGET_LINE  (NOLOCK)
	WHERE TargetLineTypeID = @TargetLineTypeID
	AND PICWeek = @PICWeek
	AND PICYear = @PICYear
	AND PigFlowID = @PigFlowID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_TARGET_LINE_ID_SELECT] TO [db_sp_exec]
    AS [dbo];

