 CREATE PROCEDURE SOSched_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 5 )
AS
	SELECT *
	FROM SOSched
	WHERE CpnyID = @parm1
	   AND OrdNbr LIKE @parm2
	   AND LineRef LIKE @parm3
	   AND SchedRef LIKE @parm4
	ORDER BY CpnyID,
	   OrdNbr,
	   LineRef,
	   SchedRef

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOSched_all] TO [MSDSL]
    AS [dbo];

