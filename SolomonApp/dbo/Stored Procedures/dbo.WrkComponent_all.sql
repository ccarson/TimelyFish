 CREATE PROCEDURE WrkComponent_all
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM WrkComponent
	WHERE CmpnentID LIKE @parm1
	ORDER BY CmpnentID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[WrkComponent_all] TO [MSDSL]
    AS [dbo];

