 create proc ADG_GLWildcard_IT2
	@InvtID	varchar(30)
as
	select		OMCOGSAcct,
			OMCOGSSub,
			OMSalesAcct,
			OMSalesSub

	from		InventoryADG (nolock)
	where		InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


