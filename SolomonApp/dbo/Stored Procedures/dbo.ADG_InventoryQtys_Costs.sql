 create proc ADG_InventoryQtys_Costs
	@InvtID	varchar(30)
as
	select	BMIStdCost,
		StdCost
	from	Inventory
	where	InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventoryQtys_Costs] TO [MSDSL]
    AS [dbo];

