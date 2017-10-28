 CREATE PROCEDURE DMG_ItemCost_InvtID_Delete
	@InvtID varchar(30)
AS

	DELETE FROM ItemCost WHERE InvtID = @InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.


