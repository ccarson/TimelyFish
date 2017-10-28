 create proc ADG_Batch_DeleteBatch
	@Module		varchar(2),
	@BatNbr		varchar(10)
as
	delete		Batch
	where		Module = @Module
	  and		BatNbr = @BatNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


