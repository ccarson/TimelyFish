 create proc ADG_InventoryQtys_QAvlParm
as
	select	InclAllocQty,
		InclQtyCustOrd,
		InclQtyOnBO,
		InclQtyOnPO
	from	INSetup

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_InventoryQtys_QAvlParm] TO [MSDSL]
    AS [dbo];

