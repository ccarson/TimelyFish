 create proc ADG_PerNbr_AR
as
	select	CurrPerNbr
	from	ARSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PerNbr_AR] TO [MSDSL]
    AS [dbo];

