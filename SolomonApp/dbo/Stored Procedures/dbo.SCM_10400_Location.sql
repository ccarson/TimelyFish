 Create	Procedure SCM_10400_Location
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@WhseLoc	VarChar(10)
As
	Select	*
		From	Location (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And WhseLoc = @WhseLoc


