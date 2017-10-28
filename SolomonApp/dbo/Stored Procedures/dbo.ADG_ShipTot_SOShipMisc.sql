 create proc ADG_ShipTot_SOShipMisc
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select		CuryMiscChrg,
			MiscChrg,
			Taxable,
			TaxCat

	from		SOShipMisc
	where		CpnyID = @CpnyID
	  and		ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


