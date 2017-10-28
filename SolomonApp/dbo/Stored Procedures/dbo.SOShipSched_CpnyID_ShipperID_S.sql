 CREATE PROCEDURE SOShipSched_CpnyID_ShipperID_S
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 15 ),
	@parm5 varchar( 5 ),
	@parm6min smalldatetime, @parm6max smalldatetime,
	@parm7 varchar( 5 )
AS
	SELECT *
	FROM SOShipSched
	WHERE CpnyID LIKE @parm1
	   AND ShipperID LIKE @parm2
	   AND ShipperLineRef LIKE @parm3
	   AND OrdNbr LIKE @parm4
	   AND OrdLineRef LIKE @parm5
	   AND ReqDate BETWEEN @parm6min AND @parm6max
	   AND OrdSchedRef LIKE @parm7
	ORDER BY CpnyID,
	   ShipperID,
	   ShipperLineRef,
	   OrdNbr,
	   OrdLineRef,
	   ReqDate,
	   OrdSchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipSched_CpnyID_ShipperID_S] TO [MSDSL]
    AS [dbo];

