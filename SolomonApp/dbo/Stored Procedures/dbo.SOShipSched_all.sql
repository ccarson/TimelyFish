 CREATE PROCEDURE SOShipSched_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 15 ),
	@parm5 varchar( 5 ),
	@parm6 varchar( 5 )
AS
	SELECT *
	FROM SOShipSched
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND ShipperLineRef LIKE @parm3
	   AND OrdNbr LIKE @parm4
	   AND OrdLineRef LIKE @parm5
	   AND OrdSchedRef LIKE @parm6
	ORDER BY CpnyID,
	   ShipperID,
	   ShipperLineRef,
	   OrdNbr,
	   OrdLineRef,
	   OrdSchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipSched_all] TO [MSDSL]
    AS [dbo];

