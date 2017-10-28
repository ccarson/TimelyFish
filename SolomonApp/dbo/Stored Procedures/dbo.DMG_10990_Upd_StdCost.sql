 Create	Proc DMG_10990_Upd_StdCost
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the ItemSite comparison table when the Standard Cost Dates don't equal
	for Standard Cost Items.  The Standard Cost Dates won't equal when Update Standard Cost from Pending has
	been process against one or more items where standard costs have changed.
*/
	Update	IN10990_ItemSite
		Set	IN10990_ItemSite.BMIDirStdCst = Case When INSetup.BMIEnabled = 1 Then ItemSite.BMIDirStdCst Else 0 End,
			IN10990_ItemSite.BMIFOvhStdCst = Case When INSetup.BMIEnabled = 1 Then ItemSite.BMIFOvhStdCst Else 0 End,
			IN10990_ItemSite.BMIStdCost = Case When INSetup.BMIEnabled = 1 Then ItemSite.BMIStdCost Else 0 End,
			IN10990_ItemSite.BMIVOvhStdCst = Case When INSetup.BMIEnabled = 1 Then ItemSite.BMIVOvhStdCst Else 0 End,
			IN10990_ItemSite.DirStdCst = ItemSite.DirStdCst,
			IN10990_ItemSite.FOvhStdCst = ItemSite.FOvhStdCst,
			IN10990_ItemSite.StdCost = ItemSite.StdCost,
			IN10990_ItemSite.VOvhStdCst = ItemSite.VOvhStdCst
		From	INSetup,
			ItemSite Join IN10990_ItemSite
			On ItemSite.InvtID = IN10990_ItemSite.InvtID
			And ItemSite.SiteID = IN10990_ItemSite.SiteID
			And ItemSite.CpnyID = IN10990_ItemSite.CpnyID
			Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	Inventory.ValMthd = 'T'
			And ItemSite.StdCostDate <> IN10990_ItemSite.StdCostDate
			AND ItemSite.InvtID LIKE @InvtIDParm


