 create proc ADG_GLWildcard_CU
	@CustID	varchar(15)
as
	select		COGSAcct,
			COGSSub,
			DiscAcct,
			DiscSub,
			FrtAcct,
			FrtSub,
			MiscAcct,
			MiscSub,
			SlsAcct,
			SlsSub
	from		CustomerEDI (nolock)
	where		CustID = @CustID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


