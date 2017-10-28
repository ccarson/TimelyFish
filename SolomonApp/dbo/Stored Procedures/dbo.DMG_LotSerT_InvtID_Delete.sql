 CREATE PROCEDURE DMG_LotSerT_InvtID_Delete
	@InvtID varchar(30)
AS

	DELETE FROM LotSerT WHERE InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_LotSerT_InvtID_Delete] TO [MSDSL]
    AS [dbo];

