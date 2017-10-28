 create proc ADG_UpdtShip_GetModuleBatches
	@Module		varchar(2),
	@JrnlType	varchar(3),
	@OrigScrnNbr	varchar(5),
	@OrigBatNbr	varchar(10)
as
	select	BatNbr

	from	Batch

	where	Module = @Module
	  and	JrnlType = @JrnlType
	  and	OrigScrnNbr = @OrigScrnNbr
	  and	OrigBatNbr = @OrigBatNbr
	  and	Status = 'V'
	  and	LUpd_Prog = '40690'	--Only return batches created by the pre-process
					--This keeps the post-process from balancing manually
					--voided batches

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


