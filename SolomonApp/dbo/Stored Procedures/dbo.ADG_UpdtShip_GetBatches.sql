 create proc ADG_UpdtShip_GetBatches
	@JrnlType	varchar(3),
	@OrigScrnNbr	varchar(5)
as
	select	Module,
		BatNbr

	from	Batch

	where	JrnlType = @JrnlType
	  and	OrigScrnNbr = @OrigScrnNbr
	  and	Status = 'V'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


