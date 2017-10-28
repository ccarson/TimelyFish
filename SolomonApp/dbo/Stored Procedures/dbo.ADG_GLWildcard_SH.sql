 create proc ADG_GLWildcard_SH
	@CustID		varchar(15),
	@ShipToID	varchar(10)
as
	select		COGSAcct,
			COGSSub,
			DiscAcct,
			DiscSub,
			FrtAcct,
			FrtSub,
			S4Future11,	-- MiscAcct - remember to change the buffer element in the ADGGLWildCard
			S4Future01,	-- MiscSub - class when restoring this, the buffer element length needs
			SlsAcct,	-- to be changed back to 24 from 30
			SlsSub
	from		SOAddress (nolock)
	where		CustID = @CustID
	  and		ShipToID = @ShipToID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


