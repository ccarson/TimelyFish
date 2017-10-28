 CREATE PROCEDURE INUnit_ToUnit
	@parm1 varchar( 6 )
AS
	SELECT *
	FROM INUnit
	WHERE ToUnit LIKE @parm1
	ORDER BY ToUnit

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


