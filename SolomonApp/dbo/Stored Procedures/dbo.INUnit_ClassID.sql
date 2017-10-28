 CREATE PROCEDURE INUnit_ClassID
	@parm1 varchar( 6 )
AS
	SELECT *
	FROM INUnit
	WHERE ClassID LIKE @parm1
	ORDER BY ClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


