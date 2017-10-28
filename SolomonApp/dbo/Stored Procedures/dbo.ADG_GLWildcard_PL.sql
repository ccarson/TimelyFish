 create proc ADG_GLWildcard_PL
	@ProdLineID	varchar(4)
as
	select		COGSAcct,
			COGSSub,
			DiscAcct,
			DiscSub,
			SlsAcct,
			SlsSub
	from		ProductLine (nolock)
	where		ProdLineID = @ProdLineID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


