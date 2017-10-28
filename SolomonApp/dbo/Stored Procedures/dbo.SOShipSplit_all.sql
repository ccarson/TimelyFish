 CREATE PROCEDURE SOShipSplit_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 10 )
AS
	SELECT *
	FROM SOShipSplit
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND SlsperID LIKE @parm3
	ORDER BY CpnyID,
	   ShipperID,
	   SlsperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipSplit_all] TO [MSDSL]
    AS [dbo];

