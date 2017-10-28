
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 04/17/2008
-- Description:	Deletes an address record 
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_ROLE_DELETE
(
	@ContactID		int
   ,@RoleTypeID		int
)
AS
BEGIN
	DELETE [$(CentralData)].dbo.ContactRoleType
	WHERE ContactID = @ContactID
	AND RoleTypeID = @RoleTypeID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ROLE_DELETE] TO [db_sp_exec]
    AS [dbo];

