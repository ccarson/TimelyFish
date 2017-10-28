 CREATE PROCEDURE DMG_SOShipPack_Count
	@CpnyID 	varchar (10),
	@ShipperID 	varchar (15)
AS
	SELECT	count(*)
	FROM 	SOShipPack
	WHERE	CpnyID = @CpnyID
	and 	ShipperID = @ShipperID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipPack_Count] TO [MSDSL]
    AS [dbo];

