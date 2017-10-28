 CREATE PROCEDURE ADG_State_Descr
	@parm1 varchar(3)
AS
	Select	Descr
	from	State
	where	StateProvID = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_State_Descr] TO [MSDSL]
    AS [dbo];

