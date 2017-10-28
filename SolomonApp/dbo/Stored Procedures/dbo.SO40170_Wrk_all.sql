 CREATE PROCEDURE SO40170_Wrk_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 15 )
AS
	SELECT *
	FROM SO40170_Wrk
	WHERE CpnyID LIKE @parm1
	   AND OrdNbr LIKE @parm2
	   AND ShipperID LIKE @parm3
	ORDER BY CpnyID,
	   OrdNbr,
	   ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SO40170_Wrk_all] TO [MSDSL]
    AS [dbo];

