 create proc ADG_UpdtShip_OpenSchedCnt
	@CpnyID		varchar(10),
	@OrdNbr		varchar(15)
as
	select	count(*)
	from	SOSched
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status = 'O'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


