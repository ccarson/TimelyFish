
CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_CLOSEOUT_SRSVCMGR_SELECT]
	@PhaseID CHAR(3)
,	@PicDate CHAR(6)
AS

DECLARE @PicYear char(4)
DECLARE @PicWeek char(2)
DECLARE @PicStartDate datetime
DECLARE @PicEndDate datetime
SET @PicYear = '20' + LEFT(@PicDate,2)
SET @PicWeek = RIGHT(@PicDate,2)

SELECT @PicStartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
SELECT @PicEndDate = WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)


SELECT	'%', '--All--'SrSvcManager
UNION ALL
SELECT	DISTINCT
	SrSvcManager, SrSvcManager
FROM	dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
WHERE	Phase = @PhaseID
AND	MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
AND	TaskID LIKE 'MG%'
ORDER BY SrSvcManager


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CLOSEOUT_SRSVCMGR_SELECT] TO [db_sp_exec]
    AS [dbo];

