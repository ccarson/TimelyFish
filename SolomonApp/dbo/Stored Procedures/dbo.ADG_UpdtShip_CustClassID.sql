 create proc ADG_UpdtShip_CustClassID
	@CustID		varchar(15)
as
	select	ClassID
	from	Customer
	where	CustID = @CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


