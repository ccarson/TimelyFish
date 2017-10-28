 create proc ADG_PerNbr_IN
as
	select	CurrPerNbr
	from	INSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PerNbr_IN] TO [MSDSL]
    AS [dbo];

