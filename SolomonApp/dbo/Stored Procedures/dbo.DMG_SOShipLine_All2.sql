 CREATE PROCEDURE DMG_SOShipLine_All2
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
AS
	SELECT	*
	FROM	SOShipLine
	WHERE	CpnyID = @CpnyID
	  AND	ShipperID = @ShipperID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipLine_All2] TO [MSDSL]
    AS [dbo];

