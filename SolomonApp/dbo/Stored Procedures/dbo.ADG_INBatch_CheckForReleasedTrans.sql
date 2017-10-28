 create procedure ADG_INBatch_CheckForReleasedTrans

	@BatNbr varchar(10)
as

	select 	count(*)
	from	INTran
	where	BatNbr = @BatNbr
	  and	Rlsed = 1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


