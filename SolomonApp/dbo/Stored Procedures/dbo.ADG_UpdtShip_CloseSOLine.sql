 create proc ADG_UpdtShip_CloseSOLine
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15),
	@LineRef	varchar(5)
as
	update	SOLine
	set	Status = 'C'
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	LineRef = @LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


