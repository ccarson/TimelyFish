
-- =============================================
-- Author:	mdawson
-- Create date: 11/8/2007
-- Description:	selects site information
-- =============================================
CREATE PROCEDURE [dbo].[cfp_SITE_SELECT]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select site.ContactID, contact.ContactName, site.SiteID
	from [$(CentralData)].dbo.Site site (NOLOCK)
	inner join [$(CentralData)].dbo.Contact contact (NOLOCK)
		on Contact.ContactID = site.ContactID
	Order By contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_SELECT] TO [db_sp_exec]
    AS [dbo];

