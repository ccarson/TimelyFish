 Create	Proc DMG_10990_ResetValues_ItemSite
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the ItemSite comparison table by clearing any fields that
	are going to be recalculated during the validation process.
*/
	Set	NoCount On

	Update	IN10990_ItemSite
		Set	AvgCost = 0,
			BMIAvgCost = 0,
			BMITotCost = 0,
			QtyOnHand = 0,
			TotCost = 0
		Where	Changed = 1
			AND InvtID LIKE @InvtIDParm


