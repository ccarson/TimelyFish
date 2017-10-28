



CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_PHASE_SELECT]
	@picyear_week		CHAR(6)
,	@pigflowid			VARCHAR(10)
AS


SELECT	DISTINCT phase
FROM cft_rpt_PIG_Master_group_dw
WHERE picyear_week = @picyear_week
AND pigflowid = @pigflowid
ORDER BY Phase





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_PHASE_SELECT] TO [db_sp_exec]
    AS [dbo];

