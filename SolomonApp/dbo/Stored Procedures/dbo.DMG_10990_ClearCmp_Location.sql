 Create	Proc DMG_10990_ClearCmp_Location
	@InvtIDParm VARCHAR (30)
As
/*
	This procedure will delete all records in the Location comparison table
	to force all Inventory Items to be rebuilt.
*/
	Set	NoCount On

	Delete From IN10990_Location
	WHERE IN10990_Location.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_ClearCmp_Location] TO [MSDSL]
    AS [dbo];

