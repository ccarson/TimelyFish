 CREATE PROCEDURE SCM_VendItem_AlternateID
	@InvtID varchar(30),
	@VendID varchar(15),
	@SiteID varchar(10),
	@AlternateID	varchar(30)
AS

	Select DISTINCT	AlternateID
	From	VendItem
	Where	InvtID = @InvtID
	  and	VendID = @VendID
	  and	SiteID = @SiteID
	  and	AlternateID like @AlternateID
	order by AlternateID

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_VendItem_AlternateID] TO [MSDSL]
    AS [dbo];

