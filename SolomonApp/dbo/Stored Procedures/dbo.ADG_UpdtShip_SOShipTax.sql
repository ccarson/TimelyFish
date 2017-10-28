 create proc ADG_UpdtShip_SOShipTax
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	TaxID,
		TaxRate,
		TotTax,
		TotTxbl,
		CuryTotTax,
		CuryTotTxbl

	from	SOShipTax

	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


