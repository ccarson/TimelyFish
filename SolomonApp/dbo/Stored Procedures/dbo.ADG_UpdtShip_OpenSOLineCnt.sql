 create proc ADG_UpdtShip_OpenSOLineCnt
	@CpnyID	varchar(10),
	@OrdNbr	varchar(15)
as
	select	count(*)
	from	SOLine
	where	CpnyID = @CpnyID
	  and	OrdNbr = @OrdNbr
	  and	Status = 'O'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


