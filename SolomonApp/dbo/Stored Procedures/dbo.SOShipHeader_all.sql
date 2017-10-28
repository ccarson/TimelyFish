 CREATE PROCEDURE SOShipHeader_all
	@parm1 varchar( 10 ),
	@parm2 varchar( 15 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID = @parm1
	   AND ShipperID LIKE @parm2
	ORDER BY CpnyID,
	   ShipperID DESC

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


