

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/28/2010
-- Description:	Returns R&M P&L Rollup Descriptions
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_DRILLDOWN_ROLLUPDESCRIPTION]
(
	
	 @StartPeriod			int
	,@EndPeriod				int
   
)
AS
BEGIN
	
	Select '%' as RollupDescription1,
	'--All--' as RollupDescription
	Union
	Select Distinct
	RC.RollupDescription as RollupDescription1,
	RC.RollupDescription
	From  dbo.cft_REPAIRS_PROBLEM_ID_COST RC

	Where RC.GroupPeriod between @StartPeriod and @EndPeriod
		
	Order by
	RC.RollupDescription
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_DRILLDOWN_ROLLUPDESCRIPTION] TO [db_sp_exec]
    AS [dbo];

