 create procedure DMG_SO40400_CrRel_Wrk_Not_AutoAdvanced
as
	select	*
	from	SO40400_CrRel_Wrk
	where	AutoAdvanceDone = 0

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SO40400_CrRel_Wrk_Not_AutoAdvanced] TO [MSDSL]
    AS [dbo];

