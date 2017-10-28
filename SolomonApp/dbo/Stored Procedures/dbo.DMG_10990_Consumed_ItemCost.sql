 Create	Proc DMG_10990_Consumed_ItemCost
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int,
	@InvtIDParm	VARCHAR (30)
As
/*
	This procedure will remove from the ItemCost Table any records that have a
	quantity of zero.
*/
	Set	NoCount	On

	Delete	From 	ItemCost
		Where	Round(Qty, @DecPlQty) = 0
			AND InvtID LIKE @InvtIDParm


