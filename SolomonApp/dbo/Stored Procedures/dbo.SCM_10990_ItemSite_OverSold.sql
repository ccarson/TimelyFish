 Create	Procedure SCM_10990_ItemSite_OverSold
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt
As
	Select	ItemSite.InvtID, ItemSite.SiteID,
		Inventory.ValMthd, QtyUnCosted = Cast(0 As Float), QtyOnHand = Cast(0 As Float)
		From	ItemSite (NoLock) Inner Join Inventory (NoLock)
			On ItemSite.InvtID = Inventory.InvtID
		Where	Round(ItemSite.QtyOnHand, @DecPlQty) < 0
			And Inventory.ValMthd In ('A', 'F', 'L')
		Order By ItemSite.InvtID, ItemSite.SiteID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10990_ItemSite_OverSold] TO [MSDSL]
    AS [dbo];

