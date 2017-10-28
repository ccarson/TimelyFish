 create proc ADG_ARDoc_CustARAcct
	@CustID	varchar(15)
as
	select	ARAcct,
		ARSub
	from	Customer
	where	CustID = @CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


