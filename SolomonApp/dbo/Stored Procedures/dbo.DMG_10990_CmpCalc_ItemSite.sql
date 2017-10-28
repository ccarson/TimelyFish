 Create	Proc DMG_10990_CmpCalc_ItemSite
	@UserName	VarChar(10),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int,
	@InvtIDParm	VARCHAR (30)

As
/*
	This procedure will update the ItemSite comparison table with the values
	calculated off of the Summarized standardized detail Inventory transactions.
*/
	Set	NoCount	On

	Declare	@BMIEnabled	SmallInt

/*	Fill variable used to determine if BMI fields get values or are automatically defaulted to zero.	*/
	Select	@BMIEnabled = BMIEnabled
		From	INSetup

/*	Update all of the calculated fields.	*/
	Update	IN10990_ItemSite
		Set	BMITotCost = 	Case	When	@BMIEnabled = 0
							Then	0
						Else	Case	When	Inc.ValMthd In ('F', 'L', 'S')
									Then	Case	When	Cost.BMITotCost IS NULL
												Then 0
											Else	Cost.BMITotCost
											End
								Else	Case	When	Inc.BMITotCost IS NULL
											Then 0
										Else	Inc.BMITotCost
										End
							End
					End,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName,
			QtyOnHand = Inc.QtyOnHand,
			TotCost = 	Case	When	Inc.QtyOnHand = 0 /* Should already be rounded.*/
							Then	0
						Else	Case	When	Inc.ValMthd In ('F', 'L', 'S')
									Then	Case 	When 	Cost.TotCost IS NULL
											  	Then 0
											Else	Cost.TotCost
											End
								Else	Case	When 	Inc.TotCost IS NULL
											Then 0
										Else	Inc.TotCost
										End
							End
					End
 		From	IN10990_ItemSite Join vp_INCheck_ItemSite Inc
			On	IN10990_ItemSite.CpnyID = Inc.CpnyID
				And IN10990_ItemSite.InvtID = Inc.InvtID
				And IN10990_ItemSite.SiteID = Inc.SiteID
			Left Join vp_10990_Sum_CostLayers Cost
			On	IN10990_ItemSite.InvtID = Cost.InvtID
				And IN10990_ItemSite.SiteID = Cost.SiteID
		WHERE IN10990_ItemSite.InvtID LIKE @InvtIDParm

	Update	IN10990_ItemSite
		Set	AvgCost = 	Case	When	QtyOnHand = 0
							Then	AvgCost
						Else	Round(TotCost / QtyOnHand, @DecPlPrcCst)
					End,
			BMIAvgCost = 	Case	When	@BMIEnabled = 0
							Then	0
						Else	Case	When	QtyOnHand = 0 /* Should already be rounded.*/
									Then	BMIAvgCost
								Else	Round(BMITotCost / QtyOnHand, @DecPlPrcCst)
							End
					End
		Where	Changed = 1
			AND IN10990_ItemSite.InvtID LIKE @InvtIDParm
/*
	Update	IN10990_ItemSite
		Set	AvgCost =	Case	When	Inc.QtyOnHand = 0 /* Should already be rounded.*/
							Then	IN10990_ItemSite.AvgCost
						Else	Round(Inc.TotCost / Inc.QtyOnHand, @DecPlPrcCst)
					End,
			BMIAvgCost = 	Case	When	@BMIEnabled = 0
							Then	0
						Else	Case	When	Inc.QtyOnHand = 0 /* Should already be rounded.*/
									Then	IN10990_ItemSite.BMIAvgCost
								Else	Round(Inc.BMITotCost / Inc.QtyOnHand, @DecPlPrcCst)
							End
					End,
			BMITotCost = 	Case	When	@BMIEnabled = 0
							Then	0
						Else	Inc.BMITotCost
					End,
			LUpd_DateTime = GetDate(),
			LUpd_Prog = '10990',
			LUpd_User = @UserName,
			QtyOnHand = Inc.QtyOnHand,
			TotCost = 	Case	When	Inc.QtyOnHand = 0 /* Should already be rounded.*/
							Then	0
						Else	Inc.TotCost
					End
 		From	IN10990_ItemSite Join vp_INCheck_ItemSite Inc
			On	IN10990_ItemSite.CpnyID = Inc.CpnyID
				And IN10990_ItemSite.InvtID = Inc.InvtID
				And IN10990_ItemSite.SiteID = Inc.SiteID
		WHERE IN10990_ItemSite.InvtID LIKE @InvtIDParm -- though it's commented statement, but for safety of future uncomment
*/



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_CmpCalc_ItemSite] TO [MSDSL]
    AS [dbo];

