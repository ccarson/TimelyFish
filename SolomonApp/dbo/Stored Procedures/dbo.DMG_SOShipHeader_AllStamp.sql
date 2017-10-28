 create proc DMG_SOShipHeader_AllStamp
	@CpnyID		varchar(10),
	@ShipperID	varchar(15)
as
	select	*,
		convert(int, tstamp)
	from	SOShipHeader
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SOShipHeader_AllStamp] TO [MSDSL]
    AS [dbo];

