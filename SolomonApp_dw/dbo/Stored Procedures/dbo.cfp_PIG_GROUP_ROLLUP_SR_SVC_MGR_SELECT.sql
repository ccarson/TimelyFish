-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/02/2010
-- Description:	Returns Sr. Service Managers by Period or PIC week
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP_SR_SVC_MGR_SELECT]
	@PhaseID char(3)
,	@PeriodOrWeek CHAR(1)
,	@Period char(7)
,	@PicDate char(6)
AS
BEGIN
	DECLARE @StartDate datetime
	DECLARE @EndDate datetime

	IF @PeriodOrWeek = 'P' 
	-- Period
	BEGIN
		DECLARE @FiscalPeriod char(2)
		DECLARE @FiscalYear char(4)
		SET @FiscalPeriod = RIGHT(@Period,2)
		SET @FiscalYear = '20' + LEFT(@Period,2)
	
		SELECT @StartDate = MIN(WeekOfDate), @EndDate = MAX(WeekEndDate) 
		FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE FiscalYear = CAST(@FiscalYear AS INT) AND FiscalPeriod = CAST(@FiscalPeriod AS INT)
	END
	ELSE
	-- Week
	BEGIN
		DECLARE @PicWeek char(2)
		DECLARE @PicYear char(4)
		SET @PicWeek = RIGHT(@PicDate,2)
		SET @PicYear = '20' + LEFT(@PicDate,2)
	
		SELECT @StartDate = WeekOfDate, @EndDate = WeekEndDate 
		FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
	END

	SELECT	'%', '--All--'SrSvcManager
	UNION ALL
	SELECT	DISTINCT
		SrSvcManager, SrSvcManager
	FROM	dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
	WHERE	Phase = @PhaseID
	AND	MasterActCloseDate BETWEEN @StartDate AND @EndDate
	AND	TaskID LIKE 'MG%'
	ORDER BY SrSvcManager
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_ROLLUP_SR_SVC_MGR_SELECT] TO [db_sp_exec]
    AS [dbo];

