 create proc ADG_GLWildcard_SI
	@SiteID	varchar(10)
as
	select		COGSAcct,
			COGSSub,
			DicsAcct,
			DiscSub,
			FrtAcct,
			FrtSub,
			S4Future11,	-- MiscAcct - remember to change the buffer element in the ADGGLWildCard
			S4Future01,	-- MiscSub - class when restoring this, the buffer element length needs
			SlsAcct,	-- to be changed back to 24 from 30
			SlsSub
	from		Site (nolock)
	where		SiteID = @SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


