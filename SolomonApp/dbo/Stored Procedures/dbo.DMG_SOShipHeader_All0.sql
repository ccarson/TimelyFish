 CREATE PROCEDURE DMG_SOShipHeader_All0
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
AS
	SELECT	*
	FROM	SOShipHeader
	WHERE	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_All0] TO [MSDSL]
    AS [dbo];

