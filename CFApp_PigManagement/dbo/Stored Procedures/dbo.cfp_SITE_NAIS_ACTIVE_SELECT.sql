
-- =============================================
-- Author:	Brian Cesafsky
-- Create date: 07/03/2009
-- Description:	selects NAIS data for a site
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_NAIS_ACTIVE_SELECT]
(
	@SiteID int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT NaisID
		,SiteID
		,NaisDisplayID
		,OriginalIssueDateTime
		,Active
	FROM dbo.cft_SITE_NAIS (NOLOCK)
	WHERE SiteID = @SiteID
	AND Active = 1 -- TRUE

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_NAIS_ACTIVE_SELECT] TO [db_sp_exec]
    AS [dbo];

