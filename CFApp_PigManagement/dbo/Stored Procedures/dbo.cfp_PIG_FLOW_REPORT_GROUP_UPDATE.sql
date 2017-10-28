

-- ============================================================
-- Author:		Doran Dahle
-- Create date: 09/09/2013
-- Description:	Updates a Pig Flow Report Group record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_REPORT_GROUP_UPDATE]
(
	@ReportingGroupID [int] 
	,@Reporting_Group_Description [varchar](100)
	,@UpdatedBy [varchar](50) 
)
AS
BEGIN
	UPDATE [dbo].[cft_PIG_FLOW_REPORTING_GROUP]
	SET Reporting_Group_Description = @Reporting_Group_Description
		,UpdatedDateTime = getdate()
		,UpdatedBy = @UpdatedBy
	WHERE ReportingGroupID = @ReportingGroupID
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_REPORT_GROUP_UPDATE] TO [db_sp_exec]
    AS [dbo];

