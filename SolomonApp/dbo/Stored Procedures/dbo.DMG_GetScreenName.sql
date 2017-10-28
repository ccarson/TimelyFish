 CREATE PROCEDURE DMG_GetScreenName
	@parm1 varchar (7)

WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
as
	Select	Name
	from 	vs_Screen
	where 	Number Like @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_GetScreenName] TO [MSDSL]
    AS [dbo];

