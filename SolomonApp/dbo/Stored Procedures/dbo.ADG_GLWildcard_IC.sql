 create proc ADG_GLWildcard_IC
	@GLClassID	varchar(4)
as
	select		COGSAcct,
			COGSSub,
			DiscAcct,
			DiscSub,
			SlsAcct,
			SlsSub
	from		ItemGLClass (nolock)
	where		GLClassID = @GLClassID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


