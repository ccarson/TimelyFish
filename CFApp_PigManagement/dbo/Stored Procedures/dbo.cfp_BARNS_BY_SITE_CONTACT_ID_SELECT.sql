-- =====================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/25/2008
-- Description:	Returns all the barns associated with a site
-- =====================================================================
CREATE PROCEDURE [dbo].[cfp_BARNS_BY_SITE_CONTACT_ID_SELECT]
(
	@SiteContactID		int
	,@StatusTypeID		int
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT  Barn.BarnNbr as BarnName
			,Barn.BarnID
	FROM [$(CentralData)].dbo.Barn Barn(NOLOCK)
	WHERE Barn.ContactID = @SiteContactID
	AND Barn.StatusTypeID = @StatusTypeID
	ORDER BY BarnName ASC;
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_BARNS_BY_SITE_CONTACT_ID_SELECT] TO [db_sp_exec]
    AS [dbo];

