﻿-- ====================================================
-- Author:		Brian Cesafsky
-- Create date: 01/22/2008
-- Description:	Returns all contacts that are truckers
-- ====================================================
CREATE PROCEDURE [dbo].[cfp_CONTACT_SELECT_TRUCKERS]
(
	@RoleTypeID1		int
	, @RoleTypeID2		int
	, @RoleTypeID3		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT Distinct
		Contact.ContactID,
		Contact.ContactFirstName,
		Contact.ContactMiddleName,
		Contact.ContactLastName,
		Contact.ContactName,
		Contact.EMailAddress,
		Contact.ContactTypeID
	FROM [$(CentralData)].dbo.Contact Contact (NOLOCK)
	LEFT JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK)
		ON ContactRoleType.ContactID=Contact.ContactID 
	WHERE ContactRoleType.RoleTypeID in (@RoleTypeID1, @RoleTypeID2, @RoleTypeID3)
	AND StatusTypeID <> 2 -- don't include inactive records
	ORDER BY Contact.ContactName
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CONTACT_SELECT_TRUCKERS] TO [db_sp_exec]
    AS [dbo];

