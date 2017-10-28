 Create	Proc DMG_10990_CmpCalc_LotSerMst
	@UserName	VarChar(10),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int,
	@InvtIDParm	VARCHAR (30)

As
/*
	This procedure will update the LotSerMst comparison table with the values
	calculated off of the Summarized standardized detail Inventory transactions.
*/
	Set	NoCount	On

/*	Update all of the calculated fields.	*/
	Update	IN10990_LotSerMst
		Set	LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName,
			QtyOnHand = Inc.QtyOnHand
 		From	IN10990_LotSerMst Join vp_INCheck_LotSerMst Inc
			On	IN10990_LotSerMst.InvtID = Inc.InvtID
				And IN10990_LotSerMst.SiteID = Inc.SiteID
				And IN10990_LotSerMst.WhseLoc = Inc.WhseLoc
				And IN10990_LotSerMst.LotSerNbr = Inc.LotSerNbr
		WHERE IN10990_LotSerMst.InvtID LIKE @InvtIDParm


