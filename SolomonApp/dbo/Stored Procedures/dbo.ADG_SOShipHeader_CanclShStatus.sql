 CREATE PROCEDURE ADG_SOShipHeader_CanclShStatus
	@CpnyID varchar( 10 ),
	@ShipperID varchar( 15 ),
	@Status varchar( 1 )

AS
	UPDATE 	SOShipHeader
	SET 	Status = @Status
	WHERE 	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipHeader_CanclShStatus] TO [MSDSL]
    AS [dbo];

