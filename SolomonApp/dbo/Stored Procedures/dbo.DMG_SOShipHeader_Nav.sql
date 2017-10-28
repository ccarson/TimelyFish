 CREATE PROCEDURE DMG_SOShipHeader_Nav
	@CpnyID varchar(10),
	@ShipperID varchar(15)
AS
	SELECT *
	FROM SOShipHeader
	WHERE CpnyID LIKE @CpnyID
	   AND ShipperID LIKE @ShipperID
	ORDER BY ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_Nav] TO [MSDSL]
    AS [dbo];

