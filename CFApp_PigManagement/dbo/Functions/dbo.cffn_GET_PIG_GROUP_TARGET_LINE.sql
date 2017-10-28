-- =====================================================================
-- Author:		Matt Dawson
-- Create date: 11/03/2009
-- Description:	Returns Target Line for the pig group
-- =====================================================================


CREATE FUNCTION [dbo].[cffn_GET_PIG_GROUP_TARGET_LINE] (@ActStartDate smalldatetime, @PigFlowID int, @TargetLineTypeID int)
RETURNS DECIMAL(10,3)
AS


BEGIN
	DECLARE @PicWeek SMALLINT
	DECLARE @PicYear SMALLINT
	SELECT @PicWeek = PicWeek, @PicYear = PicYear FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
	WHERE @ActStartDate BETWEEN WeekOfDate AND WeekEndDate
	DECLARE @TargetLineValue DECIMAL(10,3)

	SELECT @TargetLineValue =
		cft_TARGET_LINE.TargetLineValue
		FROM dbo.cft_TARGET_LINE cft_TARGET_LINE (NOLOCK)
		WHERE cft_TARGET_LINE.PigFlowID = @PigFlowID
		AND cft_TARGET_LINE.PicYear = @PicYear
		AND cft_TARGET_LINE.PicWeek = @PicWeek
		AND cft_TARGET_LINE.TargetLineTypeID = @TargetLineTypeID


    RETURN @TargetLineValue
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cffn_GET_PIG_GROUP_TARGET_LINE] TO [db_sp_exec]
    AS [dbo];

