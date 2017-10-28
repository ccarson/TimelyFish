 CREATE PROCEDURE ADG_Territory_Descr
	@parm1 varchar (10)
AS
	Select	Descr
	from 	Territory
	where 	Territory = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Territory_Descr] TO [MSDSL]
    AS [dbo];

