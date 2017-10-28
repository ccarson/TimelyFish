
-- =============================================
-- Author:	mdawson
-- Create date: 2/21/2007
-- Description:	selects available site information
-- =============================================
CREATE PROCEDURE [dbo].[cfp_LOAD_CREW_AVAILABLE_SITES_SELECT]	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select site.ContactID, contact.ContactName, site.SiteID
	from [$(CentralData)].dbo.Site site (NOLOCK)
	inner join [$(CentralData)].dbo.Contact contact (NOLOCK)
		on Contact.ContactID = site.ContactID
--	where not exists
--		(SELECT * FROM dbo.cft_LOAD_CREW_SITES (NOLOCK) WHERE ContactID = contact.ContactID)
	Order By contact.ContactName
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_LOAD_CREW_AVAILABLE_SITES_SELECT] TO [db_sp_exec]
    AS [dbo];

