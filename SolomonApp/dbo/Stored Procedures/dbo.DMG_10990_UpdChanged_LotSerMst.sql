 Create	Proc DMG_10990_UpdChanged_LotSerMst
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the LotSerMst table for the Rebuild Quantities and Cost option
	of Integrity Check with the values calculated in the LotSerMst comparison table that are flagged
	to have changed since the last Rebuild.
*/
	Set	NoCount On

	Update	LotSerMst
		Set	QtyOnHand = IN10990_LotSerMst.QtyOnHand
		From	LotSerMst Join IN10990_LotSerMst
			On LotSerMst.InvtID = IN10990_LotSerMst.InvtID
			And LotSerMst.SiteID = IN10990_LotSerMst.SiteID
			And LotSerMst.WhseLoc = IN10990_LotSerMst.WhseLoc
			And LotSerMst.LotSerNbr = IN10990_LotSerMst.LotSerNbr
			Join vp_10990_ChangedItems Changed
			On LotSerMst.InvtID = Changed.InvtID
		WHERE	LotSerMst.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_UpdChanged_LotSerMst] TO [MSDSL]
    AS [dbo];

