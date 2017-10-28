 CREATE PROCEDURE ED850SOLine_CpnyID_EDIPOID_Lin
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3min int, @parm3max int
AS
	SELECT *
	FROM ED850SOLine
	WHERE CpnyID LIKE @parm1
	   AND EDIPOID LIKE @parm2
	   AND LineID BETWEEN @parm3min AND @parm3max
	ORDER BY CpnyID,
	   EDIPOID,
	   LineID

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


