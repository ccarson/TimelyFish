

-- =============================================
-- Author:		Mike Zimanski
-- Create date: 12/28/2010
-- Description:	Returns R&M P&L Fault Descriptions
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPAIRS_DRILLDOWN_FAULTDESCRIPTION]
(
	
	 @StartPeriod			int
	,@EndPeriod				int
   
)
AS
BEGIN
	
	Select '%' as FaultDescription1,
	'--All--' as FaultDescription
	Union
	Select Distinct
	RC.FaultDescription as FaultDescription1,
	RC.FaultDescription
	From  dbo.cft_REPAIRS_PROBLEM_ID_COST RC

	Where RC.GroupPeriod between @StartPeriod and @EndPeriod
		
	Order by
	RC.FaultDescription
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPAIRS_DRILLDOWN_FAULTDESCRIPTION] TO [db_sp_exec]
    AS [dbo];

