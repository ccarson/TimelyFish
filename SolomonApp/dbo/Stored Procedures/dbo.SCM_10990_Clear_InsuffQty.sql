 Create Procedure SCM_10990_Clear_InsuffQty
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10)
As
	Update	INTran
		Set	INSuffQty = 0,
			QtyUnCosted = 0,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		From	INTran
		Where	INTran.InvtID = @InvtID
			And INTran.SiteID = @SiteID
			And INTran.INSuffQty = 1


