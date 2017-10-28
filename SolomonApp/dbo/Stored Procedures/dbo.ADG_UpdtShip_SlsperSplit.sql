 create proc ADG_UpdtShip_SlsperSplit
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
as
	select	'CreditPct' = S4Future03,
		SlsperID

	from	SOShipLineSplit
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	  and	LineRef = @LineRef
	order by CreditPct

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


