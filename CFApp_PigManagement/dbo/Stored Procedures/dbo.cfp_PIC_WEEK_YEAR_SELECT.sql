
-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 11/11/2009
-- Description:	Returns all PIC weeks and years (formatted)
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_PIC_WEEK_YEAR_SELECT]
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT	-1 FiscalPeriod
			, -1 FiscalYear
			, 9999 PICWeek
			, 9999 PICYear
			, '--Current--' PICYear_Week
			, GetDate() WeekEndDate
			, GetDate() WeekOfDate
	UNION ALL
	SELECT FiscalPeriod
		, FiscalYear
		, PICWeek
		, PICYear
		, RIGHT(PICYear, 2) + 'WK' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(PICWeek))))) + RTRIM(CONVERT(char(2), RTRIM(PICWeek))) AS PICYear_Week
		, WeekEndDate
		, WeekOfDate
	FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
--Changed to -9 days to allow the most current week to be a drop down option sooner
	WHERE WeekOfDate <= DATEADD(d,-9,GETDATE())
	AND WeekOfDate >= DATEADD(d,-364, GETDATE())
	ORDER BY PICYear DESC, PICWeek DESC
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIC_WEEK_YEAR_SELECT] TO [db_sp_exec]
    AS [dbo];

