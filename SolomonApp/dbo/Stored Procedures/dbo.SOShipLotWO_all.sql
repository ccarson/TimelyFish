 CREATE PROCEDURE SOShipLotWO_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 ),
	@parm3 varchar( 5 )
AS
	SELECT *
	FROM SOShipLotWO
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	   AND BuildLotSerRef LIKE @parm3
	ORDER BY CpnyID,
	   ShipperID,
	   BuildLotSerRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipLotWO_all] TO [MSDSL]
    AS [dbo];

