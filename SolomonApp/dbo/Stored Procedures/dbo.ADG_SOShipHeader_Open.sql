 CREATE PROCEDURE ADG_SOShipHeader_Open
	@CpnyID varchar(10),
	@ShipperID varchar(15)
AS
	SELECT 	*
	FROM 	SOShipHeader
	WHERE 	CpnyID LIKE @CpnyID
	  AND 	ShipperID LIKE @ShipperID
	  AND	Status = 'O'
	ORDER BY CpnyID,
	   ShipperID DESC

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


