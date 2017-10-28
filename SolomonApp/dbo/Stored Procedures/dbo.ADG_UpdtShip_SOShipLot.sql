 create proc ADG_UpdtShip_SOShipLot
	@CpnyID		varchar(10),
	@ShipperID	varchar(15),
	@LineRef	varchar(5)
as
	select	LotSerNbr,
--		MfgrLotSerNbr,
		convert(char(25), S4Future02),	-- MfgrLotSerNbr
		QtyPick,
		QtyShip,
		StdQtyShip = S4Future04,
		RMADisposition,
--		ShipContCode,
		space(20),			-- ShipContCode
--		SpecificCostID,
		convert(char(25), S4Future01),	-- SpecificCostID
		WhseLoc

	from	SOShipLot

	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID
	  and	LineRef = @LineRef

	order by
		CpnyID,
		ShipperID,
		LineRef,
                WhseLoc,
                		S4Future01

                

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


