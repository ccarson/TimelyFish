 CREATE PROCEDURE DMG_SOVoidInvc_UpdtShipRegID
	@RegisterID varchar( 10 ),
	@CpnyID varchar(10)
AS
	UPDATE 	SOVoidInvc
	SET 	ShipRegisterID = @RegisterID
	WHERE 	ShipRegisterID = ''
	  AND	CpnyID like @CpnyID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOVoidInvc_UpdtShipRegID] TO [MSDSL]
    AS [dbo];

