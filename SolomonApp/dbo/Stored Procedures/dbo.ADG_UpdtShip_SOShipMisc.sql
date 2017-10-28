 create proc ADG_UpdtShip_SOShipMisc
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	MiscChrgID,
		MiscChrgRef,
		MiscAcct,
		MiscSub,
		CuryMiscChrg,
		MiscChrg,
		TaxCat,
		Descr

	from	SOShipMisc
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	order by
		MiscChrgRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


