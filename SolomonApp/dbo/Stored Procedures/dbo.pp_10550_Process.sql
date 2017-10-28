 Create	Procedure pp_10550_Process
	@UserAddress	VarChar(21),
	@CpnyID		VarChar(10),
	@SiteID		VarChar(10),
	@ProgName	VarChar(8),
	@UserName	VarChar(10),
	@AllItems	Char(1)
As

	Set	NoCount On

	Declare	@BaseDecPl	SmallInt,
		@BMIDecPl	SmallInt,
		@DecPlPrcCst	SmallInt,
		@DecPlQty	SmallInt

	Select	@BaseDecPl = BaseDecPl,
		@BMIDecPl = BMIDecPl,
		@DecPlPrcCst = DecPlPrcCst,
		@DecPlQty = DecPlQty
		From	vp_DecPl (NoLock)

	Declare	@UpdateFlag    Char(1)
	Set	@UpdateFlag = '0'	/* 0 - Nothing Updated, 1 - Something Updated */

	Delete	From IN10550_Return
		Where	ComputerName = @UserAddress
			Or DateAdd(Day, 2, Crtd_DateTime) < GetDate()

/*
	Rollup Standard Component Cost to Inventory and ItemSite Pending Standard Costs for Kits.
*/
	Begin	Transaction

		Update	Inventory
			Set	PStdCostDate = GetDate(),
				PDirStdCost = Round(CompCost.PDirStdCst, @DecPlPrcCst),
				PStdCost = Round(CompCost.PDirStdCst
						+ Inventory.PFOvhStdCost
						+ Inventory.PVovhStdCost, @DecPlPrcCst),
				BMIPDirStdCost = Round(CompCost.BMIPDirStdCst, @DecPlPrcCst),
				BMIPStdCost = Round(CompCost.BMIPDirStdCst
						+ Inventory.PFOvhStdCost
						+ Inventory.PVOvhStdCost, @DecPlPrcCst),
				LUpd_DateTime = GetDate(),
				LUpd_Prog = @ProgName,
				LUpd_User = @UserName
			From	Inventory Inner Join INDfltSites (NoLock)
				On Inventory.InvtID = INDfltSites.InvtID
				And INDfltSites.CpnyID = @CpnyID
				Inner Join vp_10550_Kit_StdCost CompCost (NoLock)
				On Inventory.InvtID = CompCost.KitID
				And INDfltSites.DfltSiteID = CompCost.SiteID
				Inner Join Site (NoLock)
				On Site.SiteID = INDfltSites.DfltSiteID
				And Site.CpnyID = @CpnyID
				Left Join IN10550_Wrk INWork (NoLock)
				On INWork.KitID = Inventory.InvtID
				And INWork.SiteID = INDfltSites.DfltSiteID
				And INWork.ComputerName = @UserAddress
			Where	INDfltSites.DfltSiteID Like @SiteID
				And (@AllItems = '1' Or INWork.KitID Is Not Null)
		If (@@RowCount <> 0)
		Begin
			Set	@UpdateFlag = '1'
		End
		If (@@Error <> 0)
		Begin
			Goto Abort
		End

		Update	ItemSite
			Set	PStdCostDate = GetDate(),
				PDirStdCst = Round(CompCost.PDirStdCst, @DecPlPrcCst),
				PStdCst = Round(CompCost.PDirStdCst
						+ ItemSite.PFOvhStdCst
						+ ItemSite.PVOvhStdCst, @DecPlPrcCst),
				BMIPDirStdCst = Round(CompCost.BMIPDirStdCst, @DecPlPrcCst),
				BMIPStdCst = Round(CompCost.BMIPDirStdCst
						+ ItemSite.BMIPFOvhStdCst
						+ ItemSite.BMIPVOvhStdCst, @DecPlPrcCst),
				LUpd_DateTime = GetDate(),
				LUpd_Prog = @ProgName,
				LUpd_User = @UserName
			From	ItemSite Inner Join vp_10550_Kit_StdCost CompCost (NoLock)
				On ItemSite.InvtID = CompCost.KitID
				And ItemSite.SiteID = CompCost.SiteID
				Left Join IN10550_Wrk INWork (NoLock)
				On INWork.KitID = ItemSite.InvtID
				And INWork.SiteID = ItemSite.SiteID
				And INWork.ComputerName = @UserAddress
			Where	ItemSite.CpnyID = @CpnyID
				And ItemSite.SiteID Like @SiteID
				And (@AllItems = '1' Or INWork.KitID Is Not Null)

		If (@@RowCount <> 0)
		Begin
			Set	@UpdateFlag = '1'
		End
		If (@@Error <> 0)
		Begin
			Goto Abort
		End

	Commit Transaction

	   Goto Finish

Abort:
	Rollback Transaction

Finish:
-- Purge Work Records
	Delete	From IN10550_Wrk
		Where	ComputerName = @UserAddress
			Or DateAdd(Day, 1, Crtd_DateTime) < GetDate()

	Insert Into IN10550_Return
			(ComputerName, Crtd_DateTime, ErrorFlag, ErrorInvtId, ErrorMessage,
			Process_Flag)
		Values	(@UserAddress, GetDate(), '', '', '',
			@UpdateFlag)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pp_10550_Process] TO [MSDSL]
    AS [dbo];

