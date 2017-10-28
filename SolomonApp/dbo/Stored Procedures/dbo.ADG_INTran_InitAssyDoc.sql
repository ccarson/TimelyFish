 create proc ADG_INTran_InitAssyDoc
as
	select	*
	from	AssyDoc
	where	KitID = ''
	  and	RefNbr = ''
	  and	BatNbr = 'Z'
	  and	CpnyID = ''

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_InitAssyDoc] TO [MSDSL]
    AS [dbo];

