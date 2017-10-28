 CREATE PROCEDURE ADG_SOShipHeader_ClearSRegID
	@RegisterID varchar( 10 )
AS
	UPDATE 	SOShipHeader
	SET 	ShipRegisterID = ''
	WHERE 	ShipRegisterID = @RegisterID

	UPDATE	SOVoidInvc
	SET	ShipRegisterID = ''
	WHERE 	ShipRegisterID = @RegisterID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_ClearSRegID] TO [MSDSL]
    AS [dbo];

