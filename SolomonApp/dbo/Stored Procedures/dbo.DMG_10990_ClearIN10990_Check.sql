 Create	Proc DMG_10990_ClearIN10990_Check
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will delete all records in the ItemSite comparison table
	to force all Inventory Items to be rebuilt.
*/
	Set	NoCount On

	Delete From IN10990_Check
	WHERE IN10990_Check.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_ClearIN10990_Check] TO [MSDSL]
    AS [dbo];

