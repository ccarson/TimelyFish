 CREATE PROCEDURE SOStep_CpnyID_SOTypeID_Functio
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 8 ),
	@parm4 varchar( 4 )
AS
	SELECT *
	FROM SOStep
	WHERE CpnyID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	   AND FunctionID LIKE @parm3
	   AND FunctionClass LIKE @parm4
	ORDER BY CpnyID,
	   SOTypeID,
	   FunctionID,
	   FunctionClass

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOStep_CpnyID_SOTypeID_Functio] TO [MSDSL]
    AS [dbo];

