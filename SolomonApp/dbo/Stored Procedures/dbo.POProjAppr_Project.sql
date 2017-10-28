 CREATE PROCEDURE POProjAppr_Project
	@parm1 varchar( 16 )
AS
	SELECT *
	FROM POProjAppr
	WHERE Project LIKE @parm1
	ORDER BY Project

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[POProjAppr_Project] TO [MSDSL]
    AS [dbo];

