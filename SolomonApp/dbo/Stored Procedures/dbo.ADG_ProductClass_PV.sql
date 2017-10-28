 CREATE PROCEDURE ADG_ProductClass_PV
	@parm1 varchar(6)
AS
	SELECT ClassID, Descr
	FROM ProductClass
	WHERE ClassID like @parm1
	ORDER BY ClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


