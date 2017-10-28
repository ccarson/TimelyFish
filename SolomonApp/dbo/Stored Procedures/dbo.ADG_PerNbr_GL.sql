 create proc ADG_PerNbr_GL
as
	select	PerNbr
	from	GLSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PerNbr_GL] TO [MSDSL]
    AS [dbo];

