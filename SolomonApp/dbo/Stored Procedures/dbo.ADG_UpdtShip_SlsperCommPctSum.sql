﻿ create proc ADG_UpdtShip_SlsperCommPctSum
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
as
	select	sum(CreditPct)	-- CommPct

	from	SOShipLineSplit
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	  and	LineRef = @LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


