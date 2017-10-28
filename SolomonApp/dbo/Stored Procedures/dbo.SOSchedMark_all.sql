 CREATE PROCEDURE SOSchedMark_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 5 )
AS
	SELECT *
	FROM SOSchedMark
	WHERE CpnyID = @parm1
	   AND OrdNbr LIKE @parm2
	   AND LineRef LIKE @parm3
	   AND SchedRef LIKE @parm4
	ORDER BY CpnyID,
	   OrdNbr,
	   LineRef,
	   SchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOSchedMark_all] TO [MSDSL]
    AS [dbo];

