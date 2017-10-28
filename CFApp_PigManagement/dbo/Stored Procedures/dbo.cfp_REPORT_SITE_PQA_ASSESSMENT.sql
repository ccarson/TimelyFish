-- =========================================================
-- Author:	Brian Cesafsky
-- Create date: 07/10/2009
-- Description:	Selects PQA Assessment records for a report
-- =========================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_PQA_ASSESSMENT]
(
		@SiteID										varchar(12)
      , @AdvisorID									varchar(12)
      , @StartOriginalIssueDateTime					datetime
      , @EndOriginalIssueDateTime					datetime
      , @StartExpirationDateTime					datetime
      , @EndExpirationDateTime						datetime
      , @StartRenewalLeadDateTime					datetime
      , @EndRenewalLeadDateTime						datetime
)
AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
	SET NOCOUNT ON;

	if rtrim(@SiteID) = '-1'
		set @SiteID = '%'
	else
		set @SiteID = '%' + @SiteID

	if rtrim(@AdvisorID) = '-1'
		set @AdvisorID = '%'
	else
		set @AdvisorID = '%' + @AdvisorID

	if @StartOriginalIssueDateTime is null
		set @StartOriginalIssueDateTime = '1/1/1900'

	if @EndOriginalIssueDateTime is null
		set @EndOriginalIssueDateTime = '1/1/3000'

	if @StartExpirationDateTime is null
		set @StartExpirationDateTime = '1/1/1900'

	if @EndExpirationDateTime is null
		set @EndExpirationDateTime = '1/1/3000'

	if @StartRenewalLeadDateTime is null
		set @StartRenewalLeadDateTime = '1/1/1900'

	if @EndRenewalLeadDateTime is null
		set @EndRenewalLeadDateTime = '1/1/3000'

	SELECT cft_SITE_PQA_ASSESSMENT.PqaAssessmentID
       ,cft_SITE_PQA_ASSESSMENT.OriginalIssueDateTime
       ,cft_SITE_PQA_ASSESSMENT.ExpirationDateTime
       ,cft_SITE_PQA_ASSESSMENT.RenewalLeadDateTime
       ,cft_SITE_PQA_ASSESSMENT.Active
       ,cft_SITE_PQA_ASSESSMENT.SiteID
       ,cft_SITE_NAIS.NaisDisplayID
	   ,cft_SITE_NAIS.OriginalIssueDateTime as NaisOriginalIssueDateTime
       ,ContactAdvisor.ContactName Advisor
       ,ContactSite.ContactName SiteName
	FROM dbo.cft_SITE_PQA_ASSESSMENT cft_SITE_PQA_ASSESSMENT 
	   LEFT JOIN dbo.cft_SITE_NAIS cft_SITE_NAIS (NOLOCK)
			ON cft_SITE_PQA_ASSESSMENT.SiteID=cft_SITE_NAIS.SiteID  
       LEFT JOIN [$(CentralData)].dbo.Contact ContactAdvisor (NOLOCK)
            ON cft_SITE_PQA_ASSESSMENT.AdvisorID=ContactAdvisor.ContactID
       LEFT JOIN [$(CentralData)].dbo.Site Site (NOLOCK)
            ON cft_SITE_PQA_ASSESSMENT.SiteID=Site.SiteID
       LEFT JOIN [$(CentralData)].dbo.Contact ContactSite (NOLOCK)
			ON Site.ContactID=ContactSite.ContactID
	WHERE (cft_SITE_PQA_ASSESSMENT.SiteID like @SiteID)
	AND (cft_SITE_PQA_ASSESSMENT.AdvisorID like @AdvisorID)
	AND (cft_SITE_PQA_ASSESSMENT.OriginalIssueDateTime between @StartOriginalIssueDateTime and @EndOriginalIssueDateTime)
	AND (cft_SITE_PQA_ASSESSMENT.ExpirationDateTime between @StartExpirationDateTime and @EndExpirationDateTime)
	AND (cft_SITE_PQA_ASSESSMENT.RenewalLeadDateTime between @StartRenewalLeadDateTime and @EndRenewalLeadDateTime)
    AND cft_SITE_PQA_ASSESSMENT.Active = 1
ORDER BY cft_SITE_PQA_ASSESSMENT.RenewalLeadDateTime asc
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_PQA_ASSESSMENT] TO [db_sp_exec]
    AS [dbo];

