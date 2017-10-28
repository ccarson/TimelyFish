 create proc ADG_UpdtShip_Function
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	NextFunctionID,
		NextFunctionClass
	from	SOShipHeader
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


