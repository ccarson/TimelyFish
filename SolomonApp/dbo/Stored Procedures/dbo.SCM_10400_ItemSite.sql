 Create	Procedure SCM_10400_ItemSite
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt
As
	Select	*
		From	ItemSite (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID


