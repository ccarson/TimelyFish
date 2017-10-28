 Create	Procedure Std_Cost_Kit
	@CpnyID	VarChar(10),
	@SiteID	VarChar(10),
	@KitID	VarChar(30)
As
	Select	Kit.*, ItemSite.SiteID
		From	Kit (NoLock) Inner Join Inventory (NoLock)
			On Kit.KitID = Inventory.InvtID
			Inner Join ItemSite (NoLock)
			On Inventory.InvtID = ItemSite.InvtID
		Where	Kit.KitType <> 'B' /* Bill of Material */
			And Inventory.ValMthd = 'T'	/* Standard Cost */
			And ItemSite.CpnyID = @CpnyID
			And Kit.KitID Like @KitID
			And ItemSite.SiteID Like @SiteID
		Order By Kit.KitID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Std_Cost_Kit] TO [MSDSL]
    AS [dbo];

