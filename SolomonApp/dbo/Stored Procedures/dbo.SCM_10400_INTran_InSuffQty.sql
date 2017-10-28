 Create	Procedure SCM_10400_INTran_InSuffQty
	@InvtID		VarChar(30),
	@SiteID		VarChar(10)
As
	Select	Top 1
		*
		From	INTran (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And InSuffQty = 1


