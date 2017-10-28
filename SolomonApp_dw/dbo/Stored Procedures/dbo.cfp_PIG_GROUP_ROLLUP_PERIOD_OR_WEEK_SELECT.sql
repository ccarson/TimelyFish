-- ========================================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2009
-- Description:	Returns all Fiscal periods (formatted) or PIC weeks (formatted) by PHASE
-- ========================================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP_PERIOD_OR_WEEK_SELECT]

	@PhaseID CHAR(3)
	,@PeriodOrWeek CHAR(1)

AS
DECLARE @MaxDate datetime
SET @MaxDate = (SELECT MAX(MasterActCloseDate) FROM  dbo.cfv_PIG_GROUP_ROLLUP_DETAILS WHERE Phase like @PhaseID)

BEGIN
	SET NOCOUNT ON;

	IF @PeriodOrWeek = 'W' 
	-- Week
	BEGIN
		SELECT PICYear
			,PICWeek
			,RIGHT(PICYear, 2) + 'WK' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(PICWeek))))) + RTRIM(CONVERT(char(2), RTRIM(PICWeek))) AS PeriodOrWeek
		FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
		WHERE WeekOfDate <= @MaxDate
		AND WeekOfDate >= DATEADD(d,-364, @MaxDate)
		ORDER BY PICYear DESC, PICWeek DESC
	END
	ELSE
	-- Period
	BEGIN
		SELECT distinct FiscalYear
			,FiscalPeriod
			,RIGHT(FiscalYear, 2) + 'Per' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(FiscalPeriod))))) + RTRIM(CONVERT(char(2), RTRIM(FiscalPeriod))) AS PeriodOrWeek
		FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
		WHERE WeekOfDate <= @MaxDate
		AND WeekOfDate >= DATEADD(d,-364, @MaxDate)
		ORDER BY FiscalYear DESC, FiscalPeriod DESC
	END
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_ROLLUP_PERIOD_OR_WEEK_SELECT] TO [db_sp_exec]
    AS [dbo];

