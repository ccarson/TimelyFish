 create proc DMG_SO40400_CrRel_Wrk_Del_AutoAdvanced
as
	delete
	from	SO40400_CrRel_Wrk
	where	AutoAdvanceDone = 1

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SO40400_CrRel_Wrk_Del_AutoAdvanced] TO [MSDSL]
    AS [dbo];

