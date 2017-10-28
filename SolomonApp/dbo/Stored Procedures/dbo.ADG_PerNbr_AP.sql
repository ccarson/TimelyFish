 create proc ADG_PerNbr_AP
as
	select	CurrPerNbr
	from	APSetup (nolock)

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_PerNbr_AP] TO [MSDSL]
    AS [dbo];

