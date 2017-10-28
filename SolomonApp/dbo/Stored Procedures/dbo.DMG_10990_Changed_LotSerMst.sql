 Create	Proc DMG_10990_Changed_LotSerMst
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will update the LotSerMst comparison table
	so that only records that have changed are flagged.
*/
	Set	NoCount On

	Update	IN10990_LotSerMst
		Set Changed = 0
	WHERE IN10990_LotSerMst.InvtID LIKE @InvtIDParm

	Update	IN10990_LotSerMst
		Set Changed = 1
		From	LotSerMst Left Join IN10990_LotSerMst
			On LotSerMst.InvtID = IN10990_LotSerMst.InvtID
			And LotSerMst.SiteID = IN10990_LotSerMst.SiteID
			And LotSerMst.WhseLoc = IN10990_LotSerMst.WhseLoc
			And LotSerMst.LotSerNbr = IN10990_LotSerMst.LotSerNbr
		Where	LotSerMst.tStamp <> IN10990_LotSerMst.MstStamp
			AND IN10990_LotSerMst.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_Changed_LotSerMst] TO [MSDSL]
    AS [dbo];

