 Create	Procedure SCM_ItemSite_SiteID
	@CpnyID		VarChar(10),
	@SiteID		VarChar(10),
	@InvtID		VarChar(30)
As
	Select	*
		From	ItemSite (NoLock)
		Where	CpnyID = @CpnyID
			And SiteID = @SiteID
			And InvtID Like @InvtID


