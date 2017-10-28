 CREATE PROCEDURE SO40690_Wrk_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 10 ),
	@parm3 varchar( 15 )
AS
	SELECT *
	FROM SO40690_Wrk
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND CpnyID LIKE @parm2
	   AND ShipperID LIKE @parm3
	ORDER BY RI_ID,
	   CpnyID,
	   ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SO40690_Wrk_all] TO [MSDSL]
    AS [dbo];

