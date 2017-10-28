 create proc DMG_ShipVia_Fetch
	@CpnyID		varchar(10),
	@ShipViaID 	varchar(15)
as
	select	convert(smallint, S4Future11),	-- SatPickup
		convert(smallint, S4Future12),	-- SunPickup
		MoveOnDeliveryDays,		-- SatMove
		convert(smallint, S4Future10),	-- SunMove
		WeekendDelivery,		-- SatDelivery
		convert(smallint,S4Future09)	-- SunDelivery

	from	ShipVia
	where	CpnyID = @CpnyID
	  and	ShipViaID = @ShipViaID

-- Copyright 1999 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_ShipVia_Fetch] TO [MSDSL]
    AS [dbo];

