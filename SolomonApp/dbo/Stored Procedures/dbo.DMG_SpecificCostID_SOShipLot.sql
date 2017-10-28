 Create procedure DMG_SpecificCostID_SOShipLot
	@CpnyID	varchar(10),
	@ShipperID varchar(15),
	@LineRef varchar(5),
	@SpecificCostID varchar(25)
as
	select	distinct *
	from	SOShipLot
	where	CpnyID like @CpnyID
	and	ShipperID like @ShipperID
	and	LineRef like @LineRef
	and	S4Future01 like @SpecificCostID
	order by S4Future01

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SpecificCostID_SOShipLot] TO [MSDSL]
    AS [dbo];

