 CREATE PROCEDURE SOType_CpnyID_SOTypeID_Behavio
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 4 )
AS
	SELECT *
	FROM SOType
	WHERE CpnyID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	   AND Behavior LIKE @parm3
	ORDER BY CpnyID,
	   SOTypeID,
	   Behavior

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOType_CpnyID_SOTypeID_Behavio] TO [MSDSL]
    AS [dbo];

