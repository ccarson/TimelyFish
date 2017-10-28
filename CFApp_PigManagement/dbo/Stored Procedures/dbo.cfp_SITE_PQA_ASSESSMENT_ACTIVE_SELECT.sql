
-- =====================================================
-- Author:	Brian Cesafsky
-- Create date: 07/07/2009
-- Description:	selects PQA+ Assessment data for a site
-- =====================================================
CREATE PROCEDURE [dbo].[cfp_SITE_PQA_ASSESSMENT_ACTIVE_SELECT]
(
	@SiteID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT PqaAssessmentID
		,SiteID
		,AdvisorID
		,OriginalIssueDateTime
		,ExpirationDateTime
		,RenewalLeadDateTime
		,Active
	FROM dbo.cft_SITE_PQA_ASSESSMENT(NOLOCK)
	WHERE SiteID = @SiteID
	AND Active = 1 -- TRUE

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_PQA_ASSESSMENT_ACTIVE_SELECT] TO [db_sp_exec]
    AS [dbo];

