 create proc ADG_ARDoc_InitARTran
as
	select	*
	from	ARTran
	where	CustID = 'Z'
	  and	TranType = 'Z'
	  and	RefNbr = 'Z'
	  and	LineNbr = -1
	  and	RecordID = -1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


