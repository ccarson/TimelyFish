 CREATE PROCEDURE SCM_VendItem_VendID
	@InvtID varchar(30),
	@VendID varchar(15)

AS

	Select 	Distinct Vendor.*
	From	Vendor
		INNER JOIN VendItem
		ON Vendor.VendID = VendItem.VendID
	Where	VendItem.InvtID = @InvtID
	  and	VendItem.VendID LIKE @VendID
	order by Vendor.VendID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_VendItem_VendID] TO [MSDSL]
    AS [dbo];

