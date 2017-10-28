
-- ===================================================================
-- Author:	Brian Cesafsky
-- Create date: 07/16/2009
-- Description:	Creates new role record
-- ===================================================================
CREATE PROCEDURE dbo.cfp_CD_ROLE_INSERT
(
	@ContactID		int
   ,@RoleTypeID		int
)
AS
BEGIN
	SET NOCOUNT ON

	INSERT [$(CentralData)].dbo.ContactRoleType
	(
		[ContactID]
	   ,[RoleTypeID]
	) 
	VALUES 
	(
		@ContactID
	   ,@RoleTypeID
	)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_CD_ROLE_INSERT] TO [db_sp_exec]
    AS [dbo];

