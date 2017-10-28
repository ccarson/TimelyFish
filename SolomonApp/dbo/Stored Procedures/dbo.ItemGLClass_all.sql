 CREATE PROCEDURE ItemGLClass_all
	@parm1 varchar( 4 )
AS
	SELECT *
	FROM ItemGLClass
	WHERE GLClassID LIKE @parm1
	ORDER BY GLClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ItemGLClass_all] TO [MSDSL]
    AS [dbo];

