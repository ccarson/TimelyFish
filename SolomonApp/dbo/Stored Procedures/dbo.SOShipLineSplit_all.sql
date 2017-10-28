 CREATE PROCEDURE SOShipLineSplit_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 ),
	@parm4 varchar( 10 )
AS
	SELECT *
	FROM SOShipLineSplit
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND LineRef LIKE @parm3
	   AND SlsperID LIKE @parm4
	ORDER BY CpnyID,
	   ShipperID,
	   LineRef,
	   SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLineSplit_all] TO [MSDSL]
    AS [dbo];

