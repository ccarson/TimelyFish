

-- =============================================================================
-- Author:		Doran Dahle
-- Create date: 09/09/2013
-- Description:	Selects Pig Flows associated with a Report Group
-- =============================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_SELECT_BY_REPORT_GROUP_ID]
(
	@ReportGroupID		int
)
AS
BEGIN
	SELECT cft_PIG_FLOW.PigFlowID
		 , cft_PIG_FLOW.PigFlowDescription
		 , cft_PIG_FLOW.PigFlowFromDate
		 , cft_PIG_FLOW.PigFlowToDate
		 , cft_PIG_FLOW.ReportingGroupID
	FROM dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
	WHERE cft_PIG_FLOW.ReportingGroupID = @ReportGroupID 
	ORDER BY cft_PIG_FLOW.PigFlowFromDate DESC
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_SELECT_BY_REPORT_GROUP_ID] TO [db_sp_exec]
    AS [dbo];

