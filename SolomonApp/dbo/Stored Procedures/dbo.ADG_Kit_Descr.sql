 CREATE PROCEDURE ADG_Kit_Descr
	@parm1 varchar(30),
	@parm2 varchar(10)
AS
	SELECT	Descr
	FROM	Kit
	WHERE	KitId = @parm1
	  AND	SiteId = @parm2
	  AND	Status = 'A'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Kit_Descr] TO [MSDSL]
    AS [dbo];

