 Create	Proc DMG_10990_ClearCmp_ItemSite
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will delete all records in the ItemSite comparison table
	to force all Inventory Items to be rebuilt.
*/
	Set	NoCount On

	Delete From IN10990_ItemSite
	WHERE IN10990_ItemSite.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_ClearCmp_ItemSite] TO [MSDSL]
    AS [dbo];

