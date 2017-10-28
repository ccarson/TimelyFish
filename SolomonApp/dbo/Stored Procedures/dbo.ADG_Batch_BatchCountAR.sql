 create proc ADG_Batch_BatchCountAR
	@BatNbr	varchar(10)
as
	select		count(*)
	from		ARDoc
	where		BatNbr = @BatNbr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


