 Create	Procedure SCM_ItemSite_InvtID_SiteID
	@InvtID		VarChar(30),
	@SiteID		VarChar(10)
	As
	Select	*
		From	ItemSite (NoLock)
		Where	InvtID = @InvtID
			And SiteID Like @SiteID
			order by InvtId, SiteId


