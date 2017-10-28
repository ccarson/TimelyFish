 create proc ADG_INTran_InitTrnsfrDoc
as
	select	*
	from	TrnsfrDoc
	where	CpnyID = ''
	  and	TrnsfrDocNbr = 'Z'

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_InitTrnsfrDoc] TO [MSDSL]
    AS [dbo];

