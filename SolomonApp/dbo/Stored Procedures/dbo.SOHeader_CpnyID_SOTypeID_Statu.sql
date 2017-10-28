 CREATE PROCEDURE SOHeader_CpnyID_SOTypeID_Statu
	@parm1 varchar( 10 ),
	@parm2 varchar( 4 ),
	@parm3 varchar( 1 )
AS
	SELECT *
	FROM SOHeader
	WHERE CpnyID LIKE @parm1
	   AND SOTypeID LIKE @parm2
	   AND Status LIKE @parm3
	ORDER BY CpnyID,
	   SOTypeID,
	   Status

-- Copyright 1998, 1999, 2000, 2001 by Solomon Software, Inc. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOHeader_CpnyID_SOTypeID_Statu] TO [MSDSL]
    AS [dbo];

