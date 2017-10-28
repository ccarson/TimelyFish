 create proc ADG_INTran_InitLotSerT
as
	select	*
	from	LotSerT
	where	BatNbr = 'Z'
	  and	KitID = ''
	  and	InvtID = ''
	  and	SiteID = ''
	  and	WhseLoc = ''
	  and	RefNbr = ''

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_InitLotSerT] TO [MSDSL]
    AS [dbo];

