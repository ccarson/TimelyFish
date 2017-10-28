-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2009
-- Description:	Returns all PIC weeks and years (formatted) by PHASE
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_PIC_WEEK_YEAR_BY_PHASE_ID_SELECT]

	@PhaseID CHAR(3)

AS
DECLARE @MaxDate datetime
SET @MaxDate = (SELECT MAX(MasterActCloseDate) FROM [$(SolomonApp_dw)].dbo.cfv_PIG_GROUP_ROLLUP_DETAILS WHERE Phase = @PhaseID)

BEGIN
	SET NOCOUNT ON;
	SELECT FiscalPeriod
		, FiscalYear
		, PICWeek
		, PICYear
		, RIGHT(PICYear, 2) + 'WK' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(PICWeek))))) + RTRIM(CONVERT(char(2), RTRIM(PICWeek))) AS PICYear_Week
		, WeekEndDate
		, WeekOfDate
	FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
	WHERE WeekOfDate <= @MaxDate
	AND WeekOfDate >= DATEADD(d,-364, @MaxDate)
	ORDER BY PICYear DESC, PICWeek DESC
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIC_WEEK_YEAR_BY_PHASE_ID_SELECT] TO [db_sp_exec]
    AS [dbo];

