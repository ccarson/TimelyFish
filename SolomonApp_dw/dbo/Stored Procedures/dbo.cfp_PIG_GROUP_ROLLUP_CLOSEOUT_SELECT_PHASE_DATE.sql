
-- ==================================================================
-- Author:		Mike Zimanski
-- Create date: 02/23/2011
-- Description:	Returns Phase and CloseOut Date
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_GROUP_ROLLUP_CLOSEOUT_SELECT_PHASE_DATE]
	@CloseOut CHAR(20)

AS
BEGIN

	SELECT DISTINCT
		MasterActCloseDate as CloseDate
	,	RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase) as PhaseID
	FROM	[$(SolomonApp)].dbo.cftPigGroup cftPigGroup (NOLOCK)
	JOIN	[$(SolomonApp)].dbo.cftContact cftContact (NOLOCK)
		ON cftContact.ContactID = cftPigGroup.SiteContactID
	JOIN	 dbo.cfv_PIG_GROUP_ROLLUP_DETAILS cfv_PIG_GROUP_ROLLUP_DETAILS (NOLOCK)
		ON CAST(cfv_PIG_GROUP_ROLLUP_DETAILS.SiteContactID AS INT) = CAST(cftPigGroup.SiteContactID AS INT)
		AND cfv_PIG_GROUP_ROLLUP_DETAILS.TaskID LIKE 'MG%'
		AND RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase)+' '+'&'+' '+ LEFT(RTRIM(CAST(MasterActCloseDate AS CHAR)),11) = @CloseOut
	ORDER BY 
	MasterActCloseDate
	,	RTRIM(cfv_PIG_GROUP_ROLLUP_DETAILS.Phase) 

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_GROUP_ROLLUP_CLOSEOUT_SELECT_PHASE_DATE] TO [db_sp_exec]
    AS [dbo];

