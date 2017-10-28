 Create	Proc DMG_10990_ClearCmp_LotSerMst
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will delete all records in the LotSerMst comparison table
	to force all Inventory Items to be rebuilt.
*/
	Set	NoCount On

	Delete From IN10990_LotSerMst
	WHERE IN10990_LotSerMst.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_ClearCmp_LotSerMst] TO [MSDSL]
    AS [dbo];

