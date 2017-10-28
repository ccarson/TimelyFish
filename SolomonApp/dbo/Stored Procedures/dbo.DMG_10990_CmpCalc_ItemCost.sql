 Create	Proc DMG_10990_CmpCalc_ItemCost
	@UserName	VarChar(10),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int,
	@InvtIDParm	VARCHAR (30)
As
/*
	This procedure will update the ItemCost comparison table with the values
	calculated off of the Summarized standardized detail Inventory transactions.
*/
	Set	NoCount	On

	Declare	@BMIEnabled	SmallInt

	Select	@BMIEnabled = BMIEnabled
		From	INSetup

	Insert	Into IN10990_ItemCost
		(BMITotCost, Changed, Crtd_DateTime, Crtd_Prog,
		Crtd_User, InvtID, LayerType, LUpd_DateTime, LUpd_Prog,
		LUpd_User, MstStamp, Qty, RcptDate, RcptNbr,
		SiteID, SpecificCostID, TotCost, UnitCost)
	Select	BMITotCost =	Case	When	@BMIEnabled = 0
						Then	0
					Else	Case	When	Round(Inc.Qty, @DecPlQty) <> 0
								Then Inc.BMITotCost
							Else	0
						End
				End,
		1, GetDate(), '10990',
		@UserName, Inc.InvtID, Inc.LayerType, GetDate(), '10990',
		@UserName, Cast(0 As Binary(8)), Inc.Qty, Inc.RcptDate, Inc.RcptNbr,
		Inc.SiteID, Inc.SpecificCostID,
		TotCost = 	Case	When	Round(Inc.Qty, @DecPlQty) <> 0
						Then	Inc.TotCost
					Else	0
				End,
		UnitCost = 	Case	When	Round(Inc.Qty, @DecPlQty) <> 0
						Then	Round(Inc.TotCost / Inc.Qty, @DecPlPrcCst)
					Else	0
				End
		From	vp_INCheck_ItemCost Inc Left Join IN10990_ItemCost
			On	Inc.InvtID = IN10990_ItemCost.InvtID
				And Inc.SiteID = IN10990_ItemCost.SiteID
				And Inc.LayerType = IN10990_ItemCost.LayerType
				And Inc.SpecificCostID = IN10990_ItemCost.SpecificCostID
				And Inc.RcptDate = IN10990_ItemCost.RcptDate
				And Inc.RcptNbr = IN10990_ItemCost.RcptNbr
		Where	IN10990_ItemCost.InvtID Is Null
			AND Inc.InvtID LIKE @InvtIDParm

	Update	IN10990_ItemCost
		Set	BMITotCost = 	Case	When	@BMIEnabled = 0
							Then	0
						Else	Case	When	Round(Inc.Qty, @DecPlQty) <> 0
									Then Inc.BMITotCost
								Else	0
							End
					End,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName,
			Qty = Inc.Qty,
			TotCost = 	Case	When	Round(Inc.Qty, @DecPlQty) <> 0
							Then	Inc.TotCost
						Else	0
					End,
			UnitCost = 	Case	When	Round(Inc.Qty, @DecPlQty) <> 0
							Then	Round(Inc.TotCost / Inc.Qty, @DecPlPrcCst)
						Else	0
					End
		From	IN10990_ItemCost Join vp_INCheck_ItemCost Inc
			On	IN10990_ItemCost.InvtID = Inc.InvtID
				And IN10990_ItemCost.SiteID = Inc.SiteID
				And IN10990_ItemCost.LayerType = Inc.LayerType
				And IN10990_ItemCost.SpecificCostID = Inc.SpecificCostID
				And IN10990_ItemCost.RcptDate = Inc.RcptDate
				And IN10990_ItemCost.RcptNbr = Inc.RcptNbr
		WHERE IN10990_ItemCost.InvtID LIKE @InvtIDParm

	Exec	DMG_10990_ConsumedCmp_ItemCost @BaseDecPl, @BMIDecPl, @DecPlPrcCst, @DecPlQty, @InvtIDParm

	Exec	DMG_10990_CleanCmp_ItemCost @UserName, @BaseDecPl, @BMIDecPl, @DecPlPrcCst, @DecPlQty, @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CmpCalc_ItemCost] TO [MSDSL]
    AS [dbo];

