 create proc ADG_UpdtShip_ShipperItems
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	InvtID
	from	SOShipLine
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	group by InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


