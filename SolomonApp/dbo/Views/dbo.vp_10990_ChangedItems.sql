 


Create	View vp_10990_ChangedItems
As
/*
	This view will be used to determine a distict listing of Inventory Items that have been
	changed since the last execution of a Rebuild.  If this is the first time that a Rebuild
	is being executed, then all Inventory IDs in the database will be returned.
*/
	Select	Distinct InvtID
		From	IN10990_LotSerMst
		Where	Changed = 1	/* True */
	Union
	Select	InvtID
		From	IN10990_Location
		Where	Changed = 1	/* True */
	Union
	Select	InvtID
		From	IN10990_ItemCost
		Where	Changed = 1	/* True */
	Union
	Select	InvtID
		From	IN10990_ItemSite
		Where	Changed = 1	/* True */

 
