 Create	Procedure StdCost_Kit_PV
	@SiteID	VarChar(10),
	@KitID	VarChar(30)
As
	Select	Kit.KitID, ItemSite.SiteID, Kit.Descr
		From 	Kit (NoLock) Inner Join Inventory (NoLock)
			On Kit.KitID = Inventory.InvtID
			Inner Join ItemSite (NoLock)
			On Inventory.InvtID = ItemSite.InvtID
		Where	Inventory.ValMthd = 'T' /* Standard Cost Valuation Method */
			And Kit.KitType <> 'B' /* Bill of Material */
			And ItemSite.SiteID Like @SiteID
			And Kit.KitID Like @KitID
	   	Order By Kit.KitId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[StdCost_Kit_PV] TO [MSDSL]
    AS [dbo];

