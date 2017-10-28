 create proc ADG_UpdtShip_KitDetail
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	BuildActQty,
		LotSerNbr,
		MfgrLotSerNbr,
		WhseLoc,
		S4Future01,
		S4Future07

	from	SOShipLotWO
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


