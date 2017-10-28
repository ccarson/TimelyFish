 Create	Proc DMG_10990_ResetValues_LotSerMst
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the LotSerMst comparison table by clearing any fields that
	are going to be recalculated during the validation process.
*/
	Set	NoCount On

	Update	IN10990_LotSerMst
		Set	QtyOnHand = 0
		Where	Changed = 1
			AND IN10990_LotSerMst.InvtID LIKE @InvtIDParm


