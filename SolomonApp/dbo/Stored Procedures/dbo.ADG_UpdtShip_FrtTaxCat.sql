 create proc ADG_UpdtShip_FrtTaxCat
	@CpnyID		varchar(10),
	@ShipViaID	varchar(15)
as
	select	TaxCat
	from	ShipVia
	where	CpnyID = @CpnyID
	  and	ShipViaID = @ShipViaID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


