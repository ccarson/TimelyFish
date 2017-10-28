

-- ============================================================
-- Author:		Doran Dahle
-- Create date: 09/09/2013
-- Description:	Selects Pig Flows Report Groups
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_REPORT_GROUP_SELECT]

AS
BEGIN
		SELECT [ReportingGroupID]
			 , [Reporting_Group_Description]
			 , [CreatedDateTime]
			 , [CreatedBy]
			 , [UpdatedDateTime]
			 , [UpdatedBy] 
		FROM dbo.[cft_PIG_FLOW_REPORTING_GROUP] (NOLOCK)
		ORDER BY [ReportingGroupID],[Reporting_Group_Description] 
	END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_REPORT_GROUP_SELECT] TO [db_sp_exec]
    AS [dbo];

