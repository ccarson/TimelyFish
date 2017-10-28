 Create	Proc DMG_10990_ResetValues_ItemCost
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the ItemCost comparison table by clearing any fields that
	are going to be recalculated during the validation process.
*/
	Set	NoCount On

	Update	IN10990_ItemCost
		Set	BMITotCost = 0,
			Qty = 0,
			TotCost = 0,
			UnitCost = 0
		Where	Changed = 1
			AND IN10990_ItemCost.InvtID LIKE @InvtIDParm


