 create procedure ADG_Release_for_Inspection
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)
as
	declare @RequireStepInsp smallint

	-- Read the shipper record to determine whether the shipper
	-- is eligible for the inspection-related steps.
	select	@RequireStepInsp = RequireStepInsp
	from	SOShipHeader
	where	CpnyID = @CpnyID
	  and	ShipperID = @ShipperID

	-- If inspection is not required, return a value of 'SKIP',
	-- meaning that the shipper should skip past the inspection-
	-- related steps in the order cycle.
	if @RequireStepInsp = 0
		select	'Status' = 'SKIP',
			'Descr'  = convert(varchar(30), '')

	-- Otherwise, return 'NEXT', meaning that the shipper should
	-- advance to the next step in the order cycle (printing the
	-- inspection order).
	else
		select	'Status' = 'NEXT',
			'Descr'  = convert(varchar(30), '')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


