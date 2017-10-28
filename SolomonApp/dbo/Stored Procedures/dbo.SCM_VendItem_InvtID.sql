 CREATE PROCEDURE SCM_VendItem_InvtID
	@InvtID varchar(30)
	AS

	Select Distinct Inventory.*
	From	Inventory
		INNER JOIN VendItem
		ON Inventory.InvtID = VendItem.InvtID
	Where	VendItem.InvtID LIKE @InvtID
	order by Inventory.InvtID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_VendItem_InvtID] TO [MSDSL]
    AS [dbo];

