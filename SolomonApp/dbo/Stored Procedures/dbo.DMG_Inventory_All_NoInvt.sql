 create proc DMG_Inventory_All_NoInvt
	@InvtID	varchar(30)
as
	select	*
	from	Inventory
	where	InvtID like @InvtID
	order by InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_All_NoInvt] TO [MSDSL]
    AS [dbo];

