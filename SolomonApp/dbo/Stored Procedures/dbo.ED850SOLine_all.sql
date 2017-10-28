 CREATE PROCEDURE ED850SOLine_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 )
AS
	SELECT *
	FROM ED850SOLine
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	   AND LineRef LIKE @parm3
	ORDER BY CpnyID,
	   OrdNbr,
	   LineRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.


