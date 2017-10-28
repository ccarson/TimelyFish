 create proc ADG_UpdtShip_InvtAcct2
	@InvtID		varchar(30)
as
	select	InvtAcct,
		InvtSub
	from	Inventory
	where	InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


