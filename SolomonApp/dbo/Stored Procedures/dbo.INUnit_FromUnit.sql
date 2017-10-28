 CREATE PROCEDURE INUnit_FromUnit
	@parm1 varchar( 6 )
AS
	SELECT *
	FROM INUnit
	WHERE FromUnit LIKE @parm1
	ORDER BY FromUnit

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


