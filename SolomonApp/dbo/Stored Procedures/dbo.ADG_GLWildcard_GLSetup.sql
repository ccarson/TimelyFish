 create proc ADG_GLWildcard_GLSetup
as
	select	ValidateAcctSub,
		ValidateAtPosting
	from	GLSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


