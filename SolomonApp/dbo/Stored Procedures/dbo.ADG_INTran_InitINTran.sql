 create proc ADG_INTran_InitINTran
as
	select	*
	from	INTran
	where	BatNbr = 'Z'
	  and	InvtID = ''
	  and	SiteID = ''
	  and	WhseLoc = ''
	  and	RefNbr = ''

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_InitINTran] TO [MSDSL]
    AS [dbo];

