 CREATE PROCEDURE SOStep_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 4 )
AS
	SELECT *
	FROM SOStep
	WHERE CpnyID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	   AND Seq LIKE @parm3
	ORDER BY CpnyID,
	   SOTypeID,
	   Seq

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOStep_all] TO [MSDSL]
    AS [dbo];

