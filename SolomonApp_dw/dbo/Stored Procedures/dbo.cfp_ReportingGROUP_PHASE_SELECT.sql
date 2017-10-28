





CREATE PROCEDURE [dbo].[cfp_ReportingGROUP_PHASE_SELECT]
	@picyear_week		CHAR(6)
,	@reportinggroupid			VARCHAR(10)
AS


SELECT	DISTINCT phase
FROM cft_rpt_PIG_Master_group_dw
WHERE picyear_week = @picyear_week
AND reportinggroupid = @reportinggroupid
ORDER BY Phase







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_ReportingGROUP_PHASE_SELECT] TO [db_sp_exec]
    AS [dbo];

