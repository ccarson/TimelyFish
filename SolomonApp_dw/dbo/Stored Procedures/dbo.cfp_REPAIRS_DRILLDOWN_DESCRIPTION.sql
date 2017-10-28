

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/28/2010
-- Description:	Returns R&M P&L Descriptions
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_DRILLDOWN_DESCRIPTION]
(
	
	 @StartPeriod			int
	,@EndPeriod				int
   
)
AS
BEGIN
	
	Select '%' as Description1,
	'--All--' as Description
	Union
	Select Distinct
	RC.Description as Description1,
	RC.Description
	From  dbo.cft_REPAIRS_PROBLEM_ID_COST RC

	Where RC.GroupPeriod between @StartPeriod and @EndPeriod
		
	Order by
	RC.Description
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_DRILLDOWN_DESCRIPTION] TO [db_sp_exec]
    AS [dbo];

