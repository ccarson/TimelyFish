 CREATE PROCEDURE WCUserGroup_CpnyId
	@parm1 varchar( 10 ),
	@parm2 varchar(15)
AS
	SELECT *
	FROM WCUserGroup
	WHERE CpnyId LIKE @parm1
	AND  UserGroupID LIKE @parm2
	ORDER BY UserGroupID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WCUserGroup_CpnyId] TO [MSDSL]
    AS [dbo];

