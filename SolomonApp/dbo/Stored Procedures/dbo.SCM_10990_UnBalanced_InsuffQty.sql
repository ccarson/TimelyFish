 Create Procedure SCM_10990_UnBalanced_InsuffQty
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt,
	@InvtIDParm	VARCHAR (30)
As
	Select	INTran.InvtID, INTran.SiteID, Inventory.ValMthd,
		QtyUnCosted = Sum(Round(INTran.QtyUnCosted, @DecPlQty)),
		QtyOnHand = Coalesce(Round(Abs(ItemSite.QtyOnHand), @DecPlQty), 0)
		From	INTran (NoLock) Left Join ItemSite (NoLock)
			On INTran.InvtID = ItemSite.InvtID
			And INTran.SiteID = ItemSite.SiteID
			Inner Join Inventory (NoLock)
			On INTran.InvtID = Inventory.InvtID
		Where	Inventory.ValMthd = 'A'
			AND INTran.InvtID LIKE @InvtIDParm
		Group By INTran.InvtID, INTran.SiteID, Inventory.ValMthd, ItemSite.QtyOnHand
		Having Sum(Round(INTran.QtyUnCosted, @DecPlQty)) <> Coalesce(Round(Abs(ItemSite.QtyOnHand), @DecPlQty), 0)
			And Coalesce(Round(ItemSite.QtyOnHand, @DecPlQty), 0) < 0

Union
	Select	INTran.InvtID, INTran.SiteID, Inventory.ValMthd,
		QtyUnCosted = Sum(Round(INTran.QtyUnCosted, @DecPlQty)),
		QtyOnHand = Coalesce(Round(Abs(ItemCost.Qty), @DecPlQty), 0)
		From	INTran (NoLock) Left Join ItemCost (NoLock)
			On INTran.InvtID = ItemCost.InvtID
			And INTran.SiteID = ItemCost.SiteID
			And ItemCost.LayerType = 'S'
			And ItemCost.RcptNbr = 'OVRSLD'
			Inner Join Inventory (NoLock)
			On INTran.InvtID = Inventory.InvtID
		Where	Inventory.ValMthd In ('F', 'L')
			AND INTran.InvtID LIKE @InvtIDParm
		Group By INTran.InvtID, INTran.SiteID, Inventory.ValMthd, ItemCost.Qty
		Having Sum(Round(INTran.QtyUnCosted, @DecPlQty)) <> Coalesce(Round(Abs(ItemCost.Qty), @DecPlQty), 0)


