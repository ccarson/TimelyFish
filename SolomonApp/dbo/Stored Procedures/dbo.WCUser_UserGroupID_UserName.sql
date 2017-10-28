 CREATE PROCEDURE WCUser_UserGroupID_UserName
	@parm1 varchar( 40 ),
	@parm2 varchar(60)
AS
	SELECT *
	FROM WCUser
	WHERE UserName LIKE @parm2
	and UserGroupID LIKE @parm1
	ORDER BY UserName, UserGroupID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WCUser_UserGroupID_UserName] TO [MSDSL]
    AS [dbo];

