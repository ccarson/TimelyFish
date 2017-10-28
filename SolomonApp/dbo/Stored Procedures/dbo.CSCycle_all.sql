 CREATE PROCEDURE CSCycle_all
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM CSCycle
	WHERE CycleID LIKE @parm1
	ORDER BY CycleID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


