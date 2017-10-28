 Create Procedure SCM_10990_Check_InsuffQty
	@DecPlQty	SmallInt,
	@InvtIDParm	VARCHAR (30)
As
	Select 	INTran.InvtID, INTran.TranAmt
		From	INTran Inner Join ItemSite (NoLock)
			On INTran.InvtID = ItemSite.InvtID
			And INTran.SiteID = ItemSite.SiteID
		Where	Round(ItemSite.QtyOnHand, @DecPlQty) >= 0
			And INTran.InSuffQty = 1
			And INTran.Qty = 0
			And INTran.Rlsed = 1
			And INTran.TranAmt <> 0
			And INTran.TranType = 'AJ'
			AND INTran.InvtID LIKE @InvtIDParm


