


-- ===================================================================
-- Author:		Doran Dahle
-- Create date: 09/09/2013
-- Description:	Creates new Pig Flow Report Group record and returns it's ID.
-- ===================================================================
CREATE PROCEDURE [dbo].[cfp_PIG_FLOW_REPORT_GROUP_INSERT]
(
	@ReportingGroupID					int		OUT,
	@Reporting_Group_Description		varchar(100),
	@CreatedBy							varchar(50)

)
AS
BEGIN
	SET NOCOUNT ON
INSERT INTO [dbo].[cft_PIG_FLOW_REPORTING_GROUP]
           ([Reporting_Group_Description]
           ,[CreatedBy])
	VALUES 
	(
		@Reporting_Group_Description
		,@CreatedBy
	)
	set @ReportingGroupID = @@identity
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_PIG_FLOW_REPORT_GROUP_INSERT] TO [db_sp_exec]
    AS [dbo];

