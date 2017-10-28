

CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_CLOSEOUT_SITE_SELECT]
	@PhaseID char(3)
,	@PicDate char(6)
,	@SrSvcManager varchar(100)
,	@SvcManager varchar(100)

AS
BEGIN

DECLARE @PicWeek char(2)
DECLARE @PicYear char(4)
DECLARE @PicStartDate datetime
DECLARE @PicEndDate datetime
SET @PicWeek = RIGHT(@PicDate,2)
SET @PicYear = '20' + LEFT(@PicDate,2)


select @PicStartDate = WeekOfDate, @PicEndDate = WeekEndDate 
from [$(SolomonApp)].dbo.cftWeekDefinition where PicWeek = @PicWeek and PicYear = @PicYear

SELECT DISTINCT
	CAST(cftPigGroup.SiteContactID AS INT) ContactID
,	RTRIM(cftContact.ContactName) ContactName
FROM	[$(SolomonApp)].dbo.cftPigGroup cftPigGroup (NOLOCK)
JOIN	[$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
	ON cftContact.ContactID = cftPigGroup.SiteContactID
JOIN	[$(SolomonApp_dw)].dbo.cfv_PIG_GROUP_ROLLUP_DETAILS cfv_PIG_GROUP_ROLLUP_DETAILS (NOLOCK)
	ON CAST(cfv_PIG_GROUP_ROLLUP_DETAILS.SiteContactID AS INT) = CAST(cftPigGroup.SiteContactID AS INT)
	AND cfv_PIG_GROUP_ROLLUP_DETAILS.TaskID LIKE 'MG%'
	AND cfv_PIG_GROUP_ROLLUP_DETAILS.Phase = @PhaseID
	AND MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
	AND RTRIM(SrSvcManager) LIKE RTRIM(@SrSvcManager)
	AND RTRIM(SvcManager) LIKE RTRIM(@SvcManager)
ORDER BY RTRIM(cftContact.ContactName)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CLOSEOUT_SITE_SELECT] TO [db_sp_exec]
    AS [dbo];

