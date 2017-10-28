 CREATE PROCEDURE SO40600_Wrk_all
	@parm1min smallint, @parm1max smallint,
	@parm2 varchar( 10 ),
	@parm3 varchar( 15 ),
	@parm4 varchar( 5 ),
	@parm5 varchar( 10 ),
	@parm6min smallint, @parm6max smallint
AS
	SELECT *
	FROM SO40600_Wrk
	WHERE RI_ID BETWEEN @parm1min AND @parm1max
	   AND CpnyID LIKE @parm2
	   AND ShipperID LIKE @parm3
	   AND LineRef LIKE @parm4
	   AND WhseLoc LIKE @parm5
	   AND Cntr BETWEEN @parm6min AND @parm6max
	ORDER BY RI_ID,
	   CpnyID,
	   ShipperID,
	   LineRef,
	   WhseLoc,
	   Cntr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SO40600_Wrk_all] TO [MSDSL]
    AS [dbo];

