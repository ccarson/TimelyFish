 create proc ADG_UpdtShip_SOShipMiscClose
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	MiscChrgRef,
		CuryMiscChrg,
		MiscChrg,
		S4Future04,
		S4Future05

	from	SOShipMisc
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


