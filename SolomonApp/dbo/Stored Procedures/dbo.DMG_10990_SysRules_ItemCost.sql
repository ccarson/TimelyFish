 Create	Proc DMG_10990_SysRules_ItemCost
	@InvtID		VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As
/*
	This procedure will return a record set containing invalid data found in the ItemCost
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

	Declare	@NegQty		SmallInt
	Select	@NegQty = NegQty
		From	INSetup

	Select	MsgNbr = Cast(16332 As SmallInt), Parm0 = Cast(ItemCost.InvtID As VarChar(30)),
		Parm1 = Cast('' As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemCost ItemCost Full Join Inventory
			On ItemCost.InvtID = Inventory.InvtID
		Where	ItemCost.InvtID = @InvtID
/*	ItemCost records with quantity on hand of zero are currently deleted, don't need to check. */
			And Round(ItemCost.Qty, @DecPlQty) <> 0
/*	ItemCost records must have an associated Inventory Record. */
			And Inventory.InvtID Is Null
	Union
	Select	MsgNbr = Cast(16337 As SmallInt), Parm0 = Cast(ItemCost.InvtID As VarChar(30)),
		Parm1 = Cast(ItemCost.SiteID As VarChar(30)), Parm2 = Cast(ItemCost.LayerType As VarChar(30)),
		Parm3 = Cast(ItemCost.RcptDate As VarChar(30)), Parm4 = Cast(ItemCost.RcptNbr As VarChar(30))
		From	IN10990_ItemCost ItemCost Full Join Inventory
			On ItemCost.InvtID = Inventory.InvtID
		Where	ItemCost.InvtID = @InvtID
/*	ItemCost records with quantity on hand of zero are currently deleted, don't need to check. */
			And Round(ItemCost.Qty, @DecPlQty) <> 0
/*	The Total Cost and Quantity must have the same sign, positive or negative when the total cost is not zero. */
			And Round(ItemCost.TotCost, @BaseDecPl) <> 0
			And Sign(ItemCost.TotCost) <> Sign(ItemCost.Qty)
	Union
	Select	MsgNbr = Cast(16338 As SmallInt), Parm0 = Cast(ItemCost.InvtID As VarChar(30)),
		Parm1 = Cast(ItemCost.SiteID As VarChar(30)), Parm2 = Cast(ItemCost.LayerType As VarChar(30)),
		Parm3 = Cast(ItemCost.RcptDate As VarChar(30)), Parm4 = Cast(ItemCost.RcptNbr As VarChar(30))
		From	IN10990_ItemCost ItemCost Full Join Inventory
			On ItemCost.InvtID = Inventory.InvtID
		Where	ItemCost.InvtID = @InvtID
/*	ItemCost records with quantity on hand of zero are currently deleted, don't need to check. */
			And Round(ItemCost.Qty, @DecPlQty) <> 0
/*	The quantity in the cost layer can't be negative when the Inventory Setup
	option to Allow Negative Quantities On Hand is disabled. */
			And @NegQty = 0
			And Round(ItemCost.Qty, @DecPlQty) < 0
	Union
	Select	MsgNbr = Cast(16339 As SmallInt), Parm0 = Cast(ItemCost.InvtID As VarChar(30)),
		Parm1 = Cast(ItemCost.SiteID As VarChar(30)), Parm2 = Cast(ItemCost.LayerType As VarChar(30)),
		Parm3 = Cast(ItemCost.SpecificCostID As VarChar(30)), Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemCost ItemCost Full Join Inventory
			On ItemCost.InvtID = Inventory.InvtID
		Where	ItemCost.InvtID = @InvtID
/*	ItemCost records with quantity on hand of zero are currently deleted, don't need to check. */
			And Round(ItemCost.Qty, @DecPlQty) <> 0
/*	The quantity in the cost layer can't be negative when the Inventory Item's valuation
	method is Specific Cost Identification. */
			And Inventory.ValMthd = 'S'
			And Round(ItemCost.Qty, @DecPlQty) < 0


