 CREATE PROCEDURE SCM_VendItem_FiscYr
	@InvtID varchar(30),
	@VendID varchar(15),
	@SiteID varchar(10),
	@AlternateID	varchar(30),
	@FiscYr varchar( 4)
AS

	Select 	Distinct FiscYr
	From	VendItem
	Where	InvtID = @InvtID
	  and	VendID = @VendID
	  and	SiteID = @SiteID
	  and	AlternateID = @AlternateID
	  and	FiscYr LIKE @FiscYr
	order by FiscYr

-- Copyright 1998 by Advanced Distribution Group, Ltd. All rights reserved.



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_VendItem_FiscYr] TO [MSDSL]
    AS [dbo];

