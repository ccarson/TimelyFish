-- ============================================================
-- Author:		Brian Cesafsky
-- Create date: 07/07/2009
-- Description:	Creates a Site PQA+ Assessment record
-- ============================================================
CREATE PROCEDURE [dbo].[cfp_SITE_PQA_ASSESSMENT_INSERT]
(	
	@SiteID [int] 
	,@AdvisorID [int] 
	,@OriginalIssueDateTime[datetime]
	,@ExpirationDateTime[datetime]
	,@RenewalLeadDateTime[datetime]
	,@Active [bit]
	,@CreatedBy [varchar](50) 
)
AS
BEGIN
	INSERT INTO dbo.cft_SITE_PQA_ASSESSMENT
	(
		SiteID
		,AdvisorID 
		,OriginalIssueDateTime
		,ExpirationDateTime
		,RenewalLeadDateTime
		,Active
		,CreatedBy
	)
	VALUES 
	(
		@SiteID
		,@AdvisorID
		,@OriginalIssueDateTime
		,@ExpirationDateTime
		,@RenewalLeadDateTime
		,@Active
		,@CreatedBy
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PQA_ASSESSMENT_INSERT] TO [db_sp_exec]
    AS [dbo];

