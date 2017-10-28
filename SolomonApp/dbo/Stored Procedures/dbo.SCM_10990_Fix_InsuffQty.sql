 Create Procedure SCM_10990_Fix_InsuffQty
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@InvtIDParm	VARCHAR (30)
As
	Update	INTran
		Set	INSuffQty = 0,
			QtyUnCosted = 0,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		From	INTran Inner Join ItemSite (NoLock)
			On INTran.InvtID = ItemSite.InvtID
			And INTran.SiteID = ItemSite.SiteID
		Where	Round(ItemSite.QtyOnHand, @DecPlQty) >= 0
			And INTran.INSuffQty = 1
			AND INTran.InvtID LIKE @InvtIDParm


