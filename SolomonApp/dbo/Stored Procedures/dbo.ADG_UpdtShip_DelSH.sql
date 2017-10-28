 create proc ADG_UpdtShip_DelSH
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	delete		SHShipPack
	where		CpnyID = @CpnyID
	  and		ShipperID = @ShipperID

	delete		SHShipHeader
	where		CpnyID = @CpnyID
	  and		ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


