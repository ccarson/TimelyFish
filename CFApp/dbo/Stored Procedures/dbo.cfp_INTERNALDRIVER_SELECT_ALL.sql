-- =============================================
-- Author:		Dave Killion
-- Create date: 11/05/2007
-- Description:	Returns all of the internal drivers
-- from Central Data
-- =============================================
CREATE PROCEDURE [dbo].[cfp_INTERNALDRIVER_SELECT_ALL]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

SELECT 
	Contact.ContactID, 
	Contact.ContactName, 
	ContactType.ContactTypeDescription, 
	Contact.EMailAddress
FROM 
	[$(CentralData)].dbo.Contact Contact (NOLOCK)
	INNER JOIN [$(CentralData)].dbo.ContactType ContactType (NOLOCK)
		ON Contact.ContactTypeID = ContactType.ContactTypeID
	left join [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK)
		ON ContactRoleType.ContactID=Contact.ContactID 
where ContactRoleType.RoleTypeID = 11
ORDER BY Contact.ContactName

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_INTERNALDRIVER_SELECT_ALL] TO [db_sp_exec]
    AS [dbo];

