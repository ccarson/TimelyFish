
CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_CLOSEOUT_SVCMGR_SELECT]
	@PhaseID CHAR(3)
,	@PicDate CHAR(6)
,	@SrSvcManager VARCHAR(100)
AS

DECLARE @PicYear char(4)
DECLARE @PicWeek char(2)
DECLARE @PicStartDate datetime
DECLARE @PicEndDate datetime
SET @PicYear = '20' + LEFT(@PicDate,2)
SET @PicWeek = RIGHT(@PicDate,2)

SELECT @PicStartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
SELECT @PicEndDate = WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)


SELECT	'%', '--All--'SvcManager
UNION ALL
SELECT	DISTINCT
	SvcManager, SvcManager
FROM	dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
WHERE	Phase = @PhaseID
AND	MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
AND	RTRIM(SrSvcManager) LIKE RTRIM(@SrSvcManager)
AND	TaskID LIKE 'MG%'

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CLOSEOUT_SVCMGR_SELECT] TO [db_sp_exec]
    AS [dbo];

