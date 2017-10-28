 Create	Proc DMG_10990_CleanCmp_ItemCost
	@UserName	VarChar(10),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int,
	@InvtIDParm	VARCHAR (30)
As
/*
	This procedure will fix fractured cost layers in the ItemCost comparison table.
*/
	Set	NoCount	On

	Declare	@CostID		Integer,
		@CostIdentity	Integer,
		@InvtID		VarChar(30),
		@SiteID		VarChar(10),
		@LayerType 	Char(2),
		@SpecificCostID	VarChar(25),
		@RcptDate	SmallDateTime,
		@RcptNbr	VarChar(10),
		@FixQty		Float,
		@NegQty		Float,
		@PosQty		Float,
		@ValMthd	Char(1),
		@Count		Integer

	Select	@CostID = 0,
		@CostIdentity = 0,
		@InvtID = '',
		@SiteID = '',
		@LayerType = '',
		@SpecificCostID = '',
		@RcptDate = '01/01/1900',
		@RcptNbr = '',
		@FixQty = 0,
		@NegQty	= 0,
		@PosQty = 0,
		@ValMthd = '',
		@Count = 0

/*
	Fixes fractures where the quantity on hand is negative and positive layers exist.
*/
	If Cursor_Status('Local', 'CleanUp') > -1
	Begin
		Close CleanUp
		Deallocate CleanUp
	End

	Declare CleanUp  Cursor Local Scroll For
		Select	ItemCost.CostIdentity, ItemCost.InvtID, ItemCost.SiteID, ItemCost.LayerType,
			ItemCost.SpecificCostID, ItemCost.RcptDate, ItemCost.RcptNbr, ItemCost.Qty, Inventory.ValMthd
		From	IN10990_ItemCost ItemCost Join Inventory
			On ItemCost.InvtID = Inventory.InvtID
			Join vp_INCheck_ItemSite ItemSite
			On ItemCost.InvtID = ItemSite.InvtID
			And ItemCost.SiteID = ItemSite.SiteID
		Where	Inventory.ValMthd <> 'S'
			And ItemCost.LayerType = 'S'
			And Round(ItemSite.QtyOnHand, @DecPlQty) < 0
			And Round(ItemCost.Qty, @DecPlQty) <> 0
			And (ItemCost.RcptNbr <> 'OVRSLD'
			Or (ItemCost.RcptNbr = 'OVRSLD'
			And ItemCost.RcptDate <> '01/01/1900')
			Or ItemCost.Qty > 0)
			AND ItemCost.InvtID LIKE @InvtIDParm
		Order By ItemCost.InvtID, ItemCost.SiteID, ItemCost.Qty, ItemCost.LayerType, ItemCost.RcptDate

	Open CleanUp

	Fetch First From CleanUp Into @CostIdentity, @InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptDate, @RcptNbr, @FixQty, @ValMthd

	While (@@Fetch_Status = 0)
	Begin

--		Select @InvtID, @SiteID, @RcptNbr, @FixQty

		Select	Top 1
			@CostID = CostIdentity,
			@NegQty = Qty
			From	IN10990_ItemCost ItemCost
			Where	ItemCost.InvtID = @InvtID
				And SiteID = @SiteID
				And LayerType = @LayerType
				And RcptDate = '01/01/1900'
				And RcptNbr = 'OVRSLD'
		Set	@Count = @@RowCount

		If	Exists(Select CostIdentity From IN10990_ItemCost Where InvtID = @InvtID
				And SiteID = @SiteID
				And LayerType = @LayerType
				And RcptDate = '01/01/1900'
				And RcptNbr = 'OVRSLD'
				And CostIdentity = @CostIdentity)
		Begin
			Set	@Count = 0
			Set	@FixQty = 0
			Goto DontProcess
		End

		If	@Count = 0
		Begin
			If @FixQty > 0
			Begin
				Update	IN10990_ItemCost
					Set	BMITotCost = 0,
						RcptDate = '01/01/1900',
						RcptNbr = 'OVRSLD',
						LayerType = 'S',
						LUpd_DateTime = GetDate(),
						LUpd_Prog = '10990',
						LUpd_User = @UserName
					Where	CostIdentity = @CostIdentity
				Set	@FixQty = 0
			End
			If @FixQty < 0
			Begin
				Update	IN10990_ItemCost
					Set	RcptDate = '01/01/1900',
						RcptNbr = 'OVRSLD',
						LayerType = 'S',
						LUpd_DateTime = GetDate(),
						LUpd_Prog = '10990',
						LUpd_User = @UserName
					Where	CostIdentity = @CostIdentity
				Set	@FixQty = 0
			End
		End
		If	Not Exists(Select CostIdentity From IN10990_ItemCost Where CostIdentity = @CostIdentity)
		Begin
			Set	@Count = 0
			Set	@FixQty = 0
		End
		If	@Count = 1
		Begin

			Delete	From IN10990_ItemCost
				Where	CostIdentity = @CostIdentity

			Update	IN10990_ItemCost
				Set	BMITotCost = 0,
					Qty = Round(Qty + @FixQty, @DecPlQty),
					TotCost = Round(Round(Qty + @FixQty, @DecPlQty) * UnitCost, @BaseDecPl),
					LUpd_DateTime = GetDate(),
					LUpd_Prog = '10990',
					LUpd_User = @UserName,
					RcptNbr = 	Case 	When Round(Qty + @FixQty, @DecPlQty) > 0
								Then	@RcptNbr
								Else	RcptNbr
							End,
					RcptDate = 	Case	When	Round(Qty + @FixQty, @DecPlQty) > 0
								Then	@RcptDate
								Else	RcptDate
							End
				Where	CostIdentity = @CostID
			Set	@FixQty = 0
		End

/*
		Select	InvtID, SiteID, RcptNbr, Qty From IN10990_ItemCost Where CostIdentity = @CostID
*/
DontProcess:
		If @FixQty = 0
		Begin
			Fetch Next From CleanUp Into @CostIdentity, @InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptDate, @RcptNbr, @FixQty, @ValMthd
		End
	End

	Close CleanUp
	Deallocate CleanUp

	Update	IN10990_ItemCost
		Set	BMITotCost = 0,
			Qty = 0,
			TotCost = 0,
			UnitCost = 0,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName
		From	IN10990_ItemCost ItemCost Join vp_10990_Sum_CostLayers SumCost
			On ItemCost.InvtID = SumCost.InvtID
			And ItemCost.SiteID = SumCost.SiteID
		Where	Round(SumCost.Qty, @DecPlQty) = 0
			And Round(ItemCost.Qty, @DecPlQty) <> 0
			AND ItemCost.InvtID LIKE @InvtIDParm
/*
		This will remove any cost layer with a qty = 0.
*/
		Exec DMG_10990_ConsumedCmp_ItemCost @BaseDecPl, @BMIDecPl, @DecPlPrcCst, @DecPlQty, @InvtIDParm

	If Cursor_Status('Local', 'CleanUp') > -1
	Begin
		Close CleanUp
		Deallocate CleanUp
	End

	Declare CleanUp  Cursor Local Scroll For
		Select	ItemCost.CostIdentity, ItemCost.InvtID, ItemCost.SiteID, ItemCost.LayerType,
			ItemCost.SpecificCostID, ItemCost.RcptDate, ItemCost.RcptNbr, ItemCost.Qty, Inventory.ValMthd
		From	IN10990_ItemCost ItemCost Join Inventory
			On ItemCost.InvtID = Inventory.InvtID
			Join vp_INCheck_ItemSite ItemSite
			On ItemCost.InvtID = ItemSite.InvtID
			And ItemCost.SiteID = ItemSite.SiteID
		Where	Inventory.ValMthd <> 'S'
			And Round(ItemSite.QtyOnHand, @DecPlQty) > 0
			And ItemCost.Qty < 0
			AND ItemCost.InvtID LIKE @InvtIDParm

	Open CleanUp

	Fetch First From CleanUp Into @CostIdentity, @InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptDate, @RcptNbr, @FixQty, @ValMthd

	While (@@Fetch_Status = 0)
	Begin
/*
		Select @InvtID, @SiteID, @RcptNbr, @FixQty
*/
/*
		This will remove any cost layer with a qty = 0.
*/
		Exec DMG_10990_ConsumedCmp_ItemCost @BaseDecPl, @BMIDecPl, @DecPlPrcCst, @DecPlQty, @InvtIDParm

		If	@ValMthd = 'F'
		Begin
			Select	Top 1
				@CostID = CostIdentity,
				@PosQty = Qty
				From	IN10990_ItemCost ItemCost
				Where	ItemCost.InvtID = @InvtID
					And SiteID = @SiteID
					And LayerType = @LayerType
					And Round(Qty, @DecPlQty) > 0
				Order By RcptDate, RcptNbr
			Set	@Count = @@RowCount
/*
			Select	InvtID, SiteID, RcptNbr, Qty From IN10990_ItemCost Where CostIdentity = @CostID
*/
		End

		If 	@ValMthd = 'L'
		Begin
			Select	Top 1
				@CostID = CostIdentity,
				@PosQty = Qty
				From	IN10990_ItemCost ItemCost
				Where	ItemCost.InvtID = @InvtID
					And SiteID = @SiteID
					And LayerType = @LayerType
					And Round(Qty, @DecPlQty) > 0
				Order By RcptDate Desc, RcptNbr Desc
			Set	@Count = @@RowCount
		End
		If @Count = 0
		Begin
			Select	@CostID = CostIdentity
				From	IN10990_ItemCost ItemCost
				Where	ItemCost.InvtID = @InvtID
					And SiteID = @SiteID
					And LayerType = @LayerType
					And RcptDate = '01/01/1900'
					And RcptNbr = 'OVRSLD'
					And CostIdentity <> @CostIdentity

			Set	@Count = @@RowCount

			If	@Count = 1
			Begin
				Delete	From IN10990_ItemCost
					Where	CostIdentity = @CostIdentity

				Update	IN10990_ItemCost
					Set	BMITotCost = 0,
						Qty = Round(Qty + @FixQty, @DecPlQty),
						TotCost = Round(Round(Qty + @FixQty, @DecPlQty) * UnitCost, @BaseDecPl),
						LUpd_DateTime = GetDate(),
						LUpd_Prog = '10990',
						LUpd_User = @UserName
					Where	CostIdentity = @CostID
			End
			Else
			Begin
				Update	IN10990_ItemCost
					Set	RcptDate = '01/01/1900',
						RcptNbr = 'OVRSLD',
						LUpd_DateTime = GetDate(),
						LUpd_Prog = '10990',
						LUpd_User = @UserName
					Where	CostIdentity = @CostIdentity
			End
			Set	@FixQty = 0
		End
		If Abs(@FixQty) = @PosQty And @FixQty <> 0
		Begin
			Delete	From IN10990_ItemCost
				Where	CostIdentity In (@CostIdentity, @CostID)

			Set	@FixQty = 0
		End
		Else
			If Abs(@FixQty) < @PosQty
			Begin
				Delete	From IN10990_ItemCost
					Where	CostIdentity = @CostIdentity
					Update	IN10990_ItemCost
					Set	BMITotCost = 0,
						Qty = Round(Qty + @FixQty, @DecPlQty),
						TotCost = Round(Round(Qty + @FixQty, @DecPlQty) * UnitCost, @BaseDecPl),
						LUpd_DateTime = GetDate(),
						LUpd_Prog = '10990',
						LUpd_User = @UserName
					Where	CostIdentity = @CostID
				Set	@FixQty = 0
			End
			Else
			If	Abs(@FixQty) > @PosQty
			Begin
				Delete	From IN10990_ItemCost
					Where	CostIdentity = @CostID
					Update	IN10990_ItemCost
					Set	BMITotCost = 0,
						Qty = Round(Qty + @PosQty, @DecPlQty),
						TotCost = Round(Round(Qty + @PosQty, @DecPlQty) * UnitCost, @BaseDecPl),
						LUpd_DateTime = GetDate(),
						LUpd_Prog = '10990',
						LUpd_User = @UserName
					Where	CostIdentity = @CostIdentity
				Set	@FixQty = Round(@FixQty + @PosQty, @DecPlQty)
			End

/*
		Select	InvtID, SiteID, RcptNbr, Qty From IN10990_ItemCost Where CostIdentity = @CostID
*/

		If @FixQty = 0
		Begin
			Fetch Next From CleanUp Into @CostIdentity, @InvtID, @SiteID, @LayerType, @SpecificCostID, @RcptDate, @RcptNbr, @FixQty, @ValMthd
		End
	End

	Close CleanUp
	Deallocate CleanUp

	Update	IN10990_ItemCost
		Set	BMITotCost = 0,
			Qty = 0,
			TotCost = 0,
			UnitCost = 0,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName
		From	IN10990_ItemCost ItemCost Join vp_10990_Sum_CostLayers SumCost
			On ItemCost.InvtID = SumCost.InvtID
			And ItemCost.SiteID = SumCost.SiteID
		Where	Round(SumCost.Qty, @DecPlQty) = 0
			And Round(ItemCost.Qty, @DecPlQty) <> 0
			AND ItemCost.InvtID LIKE @InvtIDParm

/*
	Select	Sum(Qty)
		From	IN10990_ItemCost
*/
	Exec DMG_10990_ConsumedCmp_ItemCost @BaseDecPl, @BMIDecPl, @DecPlPrcCst, @DecPlQty, @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CleanCmp_ItemCost] TO [MSDSL]
    AS [dbo];

