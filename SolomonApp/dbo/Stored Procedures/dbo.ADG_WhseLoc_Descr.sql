 CREATE PROCEDURE ADG_WhseLoc_Descr
	@parm1 varchar(10),
	@parm2 varchar(10)
AS
	SELECT	Descr
	FROM	LocTable
	WHERE	Siteid = @parm1
	  AND	WhseLoc = @parm2

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


