 create proc ADG_UpdtShip_CloseSOSched
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5),
	@SchedRef	varchar(5)
as
	update	SOLot
	set	Status = 'C'
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	LineRef = @LineRef
	  and	SchedRef = @SchedRef

	update	SOSched
	set	Status = 'C'
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	LineRef = @LineRef
	  and	SchedRef = @SchedRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


