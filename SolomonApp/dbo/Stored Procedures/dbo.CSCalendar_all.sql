 CREATE PROCEDURE CSCalendar_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 6 )
AS
	SELECT *
	FROM CSCalendar
	WHERE CycleID LIKE @parm1
	   AND CommPerNbr LIKE @parm2
	ORDER BY CycleID,
	   CommPerNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


