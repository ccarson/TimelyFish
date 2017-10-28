

-- ============================================================
-- Author:		Doran Dahle
-- Create date: 09/09/2013
-- Description:	Deletes an Pig Flow Report Group record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_REPORT_GROUP_DELETE]
(
	@ReportingGroupID [int] 
)
AS
BEGIN
	DELETE from dbo.[cft_PIG_FLOW_REPORTING_GROUP] 
	WHERE [ReportingGroupID] = @ReportingGroupID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_REPORT_GROUP_DELETE] TO [db_sp_exec]
    AS [dbo];

