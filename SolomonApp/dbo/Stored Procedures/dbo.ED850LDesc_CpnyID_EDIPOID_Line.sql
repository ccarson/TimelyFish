 CREATE PROCEDURE ED850LDesc_CpnyID_EDIPOID_Line
	@parm1 varchar( 10 ),
	@parm2 varchar( 10 ),
	@parm3min int, @parm3max int
AS
	SELECT *
	FROM ED850LDesc
	WHERE CpnyID LIKE @parm1
	   AND EDIPOID LIKE @parm2
	   AND LineID BETWEEN @parm3min AND @parm3max
	ORDER BY CpnyID,
	   EDIPOID,
	   LineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


