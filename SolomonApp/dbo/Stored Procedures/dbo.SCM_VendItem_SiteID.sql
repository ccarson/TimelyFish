 CREATE PROCEDURE SCM_VendItem_SiteID
	@InvtID varchar(30),
	@VendID varchar(15),
	@SiteID varchar(10)
	AS

	Select 	Distinct Site.*
	From	Site
		INNER JOIN VendItem
		ON Site.SiteID = VendItem.SiteID
	Where	VendItem.InvtID = @InvtID
	  and	VendItem.VendID = @VendID
	  and	VendItem.SiteID LIKE @SiteID
	order by Site.SiteID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_VendItem_SiteID] TO [MSDSL]
    AS [dbo];

