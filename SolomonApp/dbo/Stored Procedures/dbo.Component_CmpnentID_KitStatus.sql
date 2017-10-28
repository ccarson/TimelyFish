 CREATE PROCEDURE Component_CmpnentID_KitStatus
	@parm1 varchar( 30 ),
	@parm2 varchar( 1 )
AS
	SELECT *
	FROM Component
	WHERE CmpnentID LIKE @parm1
	   AND KitStatus LIKE @parm2
	ORDER BY CmpnentID,
	   KitStatus

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Component_CmpnentID_KitStatus] TO [MSDSL]
    AS [dbo];

