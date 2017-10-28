 CREATE PROCEDURE SOShipHeader_ShipRegisterID
	@parm1 varchar( 10 )
AS
	SELECT *
	FROM SOShipHeader
	WHERE ShipRegisterID LIKE @parm1
	ORDER BY ShipRegisterID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SOShipHeader_ShipRegisterID] TO [MSDSL]
    AS [dbo];

