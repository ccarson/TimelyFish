 create procedure ADG_Release_for_Update
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@ShipperID	varchar(15)
as
	-- Queue the shipper to be updated.
	exec ADG_ProcessMgr_QueueUpdSh @CpnyID, @ShipperID

	-- Return 'NEXT', meaning that the shipper should advance to
	-- the next step in the order cycle (the shipper update).
	select	'Status' = 'NEXT',
		'Descr'  = convert(varchar(30), '')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


