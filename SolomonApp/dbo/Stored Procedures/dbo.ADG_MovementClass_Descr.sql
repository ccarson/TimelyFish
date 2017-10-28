 CREATE PROCEDURE ADG_MovementClass_Descr
	@parm1 varchar(10)
AS
	SELECT	Descr
	FROM	PIMoveCl
	WHERE	MoveClass = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_MovementClass_Descr] TO [MSDSL]
    AS [dbo];

