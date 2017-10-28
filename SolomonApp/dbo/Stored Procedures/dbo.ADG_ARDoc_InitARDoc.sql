 create proc ADG_ARDoc_InitARDoc
as
	select	*
	from	ARDoc
	where	CustID = 'Z'
	  and	DocType = 'Z'
	  and	RefNbr = 'Z'
	  and	BatNbr = 'Z'
	  and	BatSeq = -1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


