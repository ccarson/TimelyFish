 CREATE PROCEDURE POProjAuth_Project
	@parm1 varchar( 16 )
AS
	SELECT *
	FROM POProjAuth
	WHERE Project LIKE @parm1
	ORDER BY Project

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POProjAuth_Project] TO [MSDSL]
    AS [dbo];

