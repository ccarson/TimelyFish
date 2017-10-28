 create proc ADG_UpdtShip_OrigInvc
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	INBatNbr,
		InvcNbr

	from	SOShipHeader

	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


