 CREATE PROCEDURE DMG_ItemHist_InvtID_Delete
	@InvtID varchar(30)
AS

	DELETE FROM ItemHist WHERE InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


