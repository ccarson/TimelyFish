﻿ create proc DMG_Inventory_Purchases
	@InvtID	varchar(30)
as
	select	*
	from	Inventory
	where	InvtID like @InvtID
	and	TranStatusCode in ('AC','NU')
	order by InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Inventory_Purchases] TO [MSDSL]
    AS [dbo];

