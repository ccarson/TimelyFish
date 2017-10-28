 CREATE PROCEDURE DMG_SOAcctSubErr_Delete_RIID
	@RI_ID 		smallint
AS
	Delete
	from	SOAcctSubErr
	where	RI_ID = @RI_ID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


