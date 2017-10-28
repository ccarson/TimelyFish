 create proc ADG_GLWildcard_IT1
	@InvtID	varchar(30)
as
	select		DiscAcct,
			DiscSub

	from		Inventory (nolock)
	where		InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


