 Create procedure DMG_SpecificCostID_Count
	@CpnyID	varchar(10),
	@ShipperID varchar(15),
	@LineRef varchar(5)
as
	select	count(distinct(SOShipLot.S4Future01))
	from	SOShipLot
	where	CpnyID like @CpnyID
	and	ShipperID like @ShipperID
	and	LineRef like @LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SpecificCostID_Count] TO [MSDSL]
    AS [dbo];

