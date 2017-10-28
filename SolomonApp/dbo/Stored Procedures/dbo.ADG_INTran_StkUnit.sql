 create proc ADG_INTran_StkUnit
	@InvtID		varchar(30)
as
	select	StkUnit
	from	Inventory
	where	InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_INTran_StkUnit] TO [MSDSL]
    AS [dbo];

