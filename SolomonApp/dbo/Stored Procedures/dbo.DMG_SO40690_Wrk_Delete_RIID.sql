 CREATE PROCEDURE DMG_SO40690_Wrk_Delete_RIID
	@RI_ID 		smallint
AS
	Delete
	from	SO40690_Wrk
	where	RI_ID = @RI_ID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_SO40690_Wrk_Delete_RIID] TO [MSDSL]
    AS [dbo];

