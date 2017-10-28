 CREATE PROCEDURE ADG_SIMatlTypes_Descr
	@parm1 varchar(10)
AS
	SELECT 	Descr
	FROM 	SIMatlTypes
	WHERE 	MaterialType = @parm1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


