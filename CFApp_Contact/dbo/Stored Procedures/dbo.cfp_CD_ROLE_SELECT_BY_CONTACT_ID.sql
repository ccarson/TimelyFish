-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 06/29/2009
-- Description:	CENTRAL DATA - Returns all addresses by contact ID 
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_CD_ROLE_SELECT_BY_CONTACT_ID]
(
	@ContactID		int
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT RoleType.RoleTypeID
		  ,RoleType.RoleTypeDescription
	FROM [$(CentralData)].dbo.RoleType RoleType (NOLOCK)
		 INNER JOIN [$(CentralData)].dbo.ContactRoleType ContactRoleType (NOLOCK)
			ON RoleType.RoleTypeID = ContactRoleType.RoleTypeID
	WHERE (ContactRoleType.ContactID = @ContactID)
	ORDER BY RoleType.RoleTypeDescription
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ROLE_SELECT_BY_CONTACT_ID] TO [db_sp_exec]
    AS [dbo];

