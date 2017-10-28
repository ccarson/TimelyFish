-- =============================================
-- Author:		Brian Cesafsky
-- Create date: 01/22/2008
-- Description:	Returns all contacts by role type
-- =============================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT_BY_ROLE_TYPE]
(
	@RoleTypeID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Contact.ContactID
		,Contact.ContactName
		,Contact.ContactTypeID
		,Contact.Title
		,Contact.ContactFirstName
		,Contact.ContactMiddleName
		,Contact.ContactLastName	
		,Contact.EMailAddress
		,Contact.TranSchedMethodTypeID
		--,Contact.DefaultContactMethodID
		,Contact.StatusTypeID
		,Contact.SolomonContactID
		,Contact.ShortName
		,ContactRoleType.RoleTypeID
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK)
		ON ContactRoleType.ContactID=Contact.ContactID 
	WHERE ContactRoleType.RoleTypeID = @RoleTypeID
	ORDER BY Contact.ContactName
END
