 create proc ADG_GLWildcard_Error
as
	select	ErrorAcct,
		ErrorSub
	from	SOSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


