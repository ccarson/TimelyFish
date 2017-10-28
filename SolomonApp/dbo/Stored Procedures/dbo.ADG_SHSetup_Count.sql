 create proc ADG_SHSetup_Count

as
	select	count(*)
	from	SHSetup

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_SHSetup_Count] TO [MSDSL]
    AS [dbo];

