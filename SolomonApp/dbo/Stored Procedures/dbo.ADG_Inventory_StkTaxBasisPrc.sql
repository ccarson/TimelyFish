 create procedure ADG_Inventory_StkTaxBasisPrc
	@InvtID	varchar(30)
as
	-- return the stock tax basis price for the passed inventory item
		select	StkTaxBasisPrc
	from	Inventory
	where	InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Inventory_StkTaxBasisPrc] TO [MSDSL]
    AS [dbo];

