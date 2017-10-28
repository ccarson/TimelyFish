 create proc ADG_POTran_BatNbr
	@BatNbr		varchar(10)
as

	select	*
	from	POTran
	where	BatNbr = @BatNbr
	Order by RcptNbr, LineRef

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


