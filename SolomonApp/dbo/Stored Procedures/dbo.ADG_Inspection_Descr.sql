 CREATE PROCEDURE ADG_Inspection_Descr
	@parm1 varchar(30),
	@parm2 varchar(2)
AS
	SELECT	Descr
	FROM	Inspection
	WHERE	InvtID = @parm1
	  AND	InspID = @parm2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inspection_Descr] TO [MSDSL]
    AS [dbo];

