 CREATE PROCEDURE DMG_Item2Hist_InvtID_Delete
	@InvtID varchar(30)
AS

	DELETE FROM Item2Hist WHERE InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_Item2Hist_InvtID_Delete] TO [MSDSL]
    AS [dbo];

