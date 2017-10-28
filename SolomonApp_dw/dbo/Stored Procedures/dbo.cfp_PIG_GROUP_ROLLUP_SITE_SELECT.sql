-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/02/2010
-- Description:	Returns SITES by Period or PIC week
-- ==================================================================
/* 
===========================================================================================
Change Log: 
Date        Author		 	   Change 
----------- ------------------ ------------------------------------------------------------ 
07/06/2017	lscott	   modified ORDER BY clause (removed prefix)
===========================================================================================
*/
CREATE PROCEDURE dbo.cfp_PIG_GROUP_ROLLUP_SITE_SELECT
	@PhaseID char(3)
,	@PeriodOrWeek CHAR(1)
,	@Period char(7)
,	@PicDate char(6)
,	@SrSvcManager varchar(100)
,	@SvcManager varchar(100)

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

	SELECT DISTINCT
		CAST(cftPigGroup.SiteContactID AS INT) ContactID
	,	RTRIM(cftContact.ContactName) ContactName
	FROM	[$(SolomonApp)].dbo.cftPigGroup cftPigGroup (NOLOCK)
	JOIN	[$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
		ON cftContact.ContactID = cftPigGroup.SiteContactID
	JOIN	 dbo.cfv_PIG_GROUP_ROLLUP_DETAILS cfv_PIG_GROUP_ROLLUP_DETAILS (NOLOCK)
		ON CAST(cfv_PIG_GROUP_ROLLUP_DETAILS.SiteContactID AS INT) = CAST(cftPigGroup.SiteContactID AS INT)
		AND cfv_PIG_GROUP_ROLLUP_DETAILS.TaskID LIKE 'MG%'
		AND cfv_PIG_GROUP_ROLLUP_DETAILS.Phase = @PhaseID
		AND MasterActCloseDate BETWEEN @StartDate AND @EndDate
		AND RTRIM(SrSvcManager) LIKE RTRIM(@SrSvcManager)
		AND RTRIM(SvcManager) LIKE RTRIM(@SvcManager)
	ORDER BY ContactName													-- lscott 7/6/2017
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_ROLLUP_SITE_SELECT] TO [db_sp_exec]
    AS [dbo];

