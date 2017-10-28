 CREATE PROCEDURE ADG_SOShipLotWO_Delete
		@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LotSerRef	varchar(5)
AS
	DELETE FROM SOShipLotWO
	WHERE	CpnyID LIKE @CpnyID AND
		ShipperID LIKE @ShipperID AND
		BuildLotSerRef LIKE @LotSerRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SOShipLotWO_Delete] TO [MSDSL]
    AS [dbo];

