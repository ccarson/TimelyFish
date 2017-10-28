 create proc ADG_GLWildcard_IT
	@InvtID	varchar(30)
as
	select		COGSAcct,
			COGSSub,
			DiscAcct,
			DiscSub,
			DfltSalesAcct,
			DfltSalesSub
	from		Inventory (nolock)
	where		InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


