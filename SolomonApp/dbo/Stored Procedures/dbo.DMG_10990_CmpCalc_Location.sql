 Create	Proc DMG_10990_CmpCalc_Location
	@UserName	VarChar(10),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int,
	@InvtIDParm	VARCHAR (30)
As
/*
	This procedure will update the Location comparison table with the values
	calculated off of the Summarized standardized detail Inventory transactions.
*/

/*	Update all of the calculated fields.	*/
	Update	IN10990_Location
		Set	LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName,
			QtyOnHand = Inc.QtyOnHand
 		From	IN10990_Location Join vp_INCheck_Location Inc
			On	IN10990_Location.InvtID = Inc.InvtID
				And IN10990_Location.SiteID = Inc.SiteID
				And IN10990_Location.WhseLoc = Inc.WhseLoc
		WHERE	IN10990_Location.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CmpCalc_Location] TO [MSDSL]
    AS [dbo];

