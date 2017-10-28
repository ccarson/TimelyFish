 CREATE PROCEDURE SOShipHeader_ShipperID_CpnyID
	@parm1 varchar( 15 ),
	@parm2 varchar( 10 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE ShipperID LIKE @parm1
	   AND CpnyID LIKE @parm2
	ORDER BY ShipperID,
	   CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


