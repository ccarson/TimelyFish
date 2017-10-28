 Create	Proc DMG_10990_ClearCmp_ItemCost
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will delete all records in the ItemCost comparison table
	to force all Inventory Items to be rebuilt.
*/
	Set	NoCount On

	Delete From IN10990_ItemCost
	WHERE IN10990_ItemCost.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_ClearCmp_ItemCost] TO [MSDSL]
    AS [dbo];

