 CREATE PROCEDURE SOType_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 )
AS
	SELECT *
	FROM SOType
	WHERE CpnyID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	ORDER BY CpnyID,
	   SOTypeID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOType_all] TO [MSDSL]
    AS [dbo];

