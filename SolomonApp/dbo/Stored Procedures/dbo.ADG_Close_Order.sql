 create procedure ADG_Close_Order
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	-- Change the order status to 'C' for 'closed'.
	update	SOHeader
	set	Status = 'C'
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr

	-- Return a status of 'DONE' from this procedure so that
	-- Order Cycle Manager knows that it should not attempt to
	-- advance to another step in the order cycle.
	select	'Status' = 'DONE',
		'Descr'  = convert(varchar(30), '')

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


