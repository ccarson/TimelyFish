 CREATE PROCEDURE INUnit_InvtId
	@parm1 varchar( 30 )
AS
	SELECT *
	FROM INUnit
	WHERE InvtId LIKE @parm1
	ORDER BY InvtId

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INUnit_InvtId] TO [MSDSL]
    AS [dbo];

