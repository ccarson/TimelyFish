 create proc ADG_Batch_BatchExists
	@Module		varchar(2),
	@BatNbr		varchar(10)
as
	declare		@BatchCount	integer
	declare		@BatchExists	smallint

	select		@BatchCount = count(*)
	from		Batch
	where		Module = @Module
	  and		BatNbr = @BatNbr

	if (@BatchCount > 0)
		select @BatchExists = 1
	else
		select @BatchExists = 0

	select @BatchExists

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


