
-- ==================================================================
-- Author:		Mike Zimanski
-- Create date: 02/23/2011
-- Description:	Returns Closeouts given Site and Date Range Selected
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP_CLOSEOUT_SELECT]
	@SiteContactID int
,	@StartDate datetime
,	@EndDate datetime

AS
BEGIN

	SELECT DISTINCT
		CAST(cftPigGroup.SiteContactID AS INT) ContactID
	,	MasterActCloseDate as CloseDate
	,	RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase) as PhaseID
	,	RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase)+' '+'&'+' '+ LEFT(RTRIM(CAST(MasterActCloseDate AS CHAR)),11) CloseOutReport
	,	RIGHT(WeekDef.PICYear, 2) + 'WK' + REPLICATE('0', 2 - LEN(RTRIM(CONVERT(char(2), RTRIM(WeekDef.PICWeek))))) + RTRIM(CONVERT(char(2), RTRIM(WeekDef.PICWeek))) AS PICYear_Week
	FROM	[$(SolomonApp)].dbo.cftPigGroup cftPigGroup (NOLOCK)
	JOIN	[$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
		ON cftContact.ContactID = cftPigGroup.SiteContactID
	JOIN	 dbo.cfv_PIG_GROUP_ROLLUP_DETAILS cfv_PIG_GROUP_ROLLUP_DETAILS (NOLOCK)
		ON CAST(cfv_PIG_GROUP_ROLLUP_DETAILS.SiteContactID AS INT) = CAST(cftPigGroup.SiteContactID AS INT)
		AND cfv_PIG_GROUP_ROLLUP_DETAILS.TaskID LIKE 'MG%'
		AND cftPigGroup.SiteContactID = @SiteContactID
		AND MasterActCloseDate BETWEEN @StartDate AND @EndDate
	JOIN	[$(SolomonApp)].dbo.cftDayDefinition DayDef
		ON MasterActCloseDate = DayDef.DayDate
	JOIN	[$(SolomonApp)].dbo.cftWeekDefinition WeekDef
		ON	DayDef.WeekOfDate = WeekDef.WeekOfDate
	WHERE RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase) <> 'TEF'
	ORDER BY 
	CAST(cftPigGroup.SiteContactID AS INT),
	RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase)+' '+'&'+' '+ LEFT(RTRIM(CAST(MasterActCloseDate AS CHAR)),11) 

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_ROLLUP_CLOSEOUT_SELECT] TO [db_sp_exec]
    AS [dbo];

