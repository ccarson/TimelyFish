-- ===============================================================================
-- Author:		Brian Cesafsky
-- Create date: 07/25/2008
-- Description:	Returns a site health record by siteContactID and siteContactDate
-- ===============================================================================
CREATE PROCEDURE [dbo].[cfp_SITE_HEALTH_SELECT_BY_SITE_CONTACT_ID_AND_DATE]
(
	@SiteContactID			int
	,@SiteContactDate		smalldatetime
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  SiteHealthID
            ,SiteContactID
            ,SiteContactDate
            ,HealthConcern
	FROM dbo.cft_SITE_HEALTH (NOLOCK)
	WHERE SiteContactID = @SiteContactID
	AND SiteContactDate = @SiteContactDate
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_HEALTH_SELECT_BY_SITE_CONTACT_ID_AND_DATE] TO [db_sp_exec]
    AS [dbo];

