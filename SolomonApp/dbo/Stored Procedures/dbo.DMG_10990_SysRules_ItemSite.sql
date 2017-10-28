 Create	Proc DMG_10990_SysRules_ItemSite
	@InvtID		VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As
/*
	This procedure will return a record set containing invalid data found in the ItemSite
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

	Declare	@NegQty		SmallInt
	Select	@NegQty = NegQty
		From	INSetup

	Select	MsgNbr = Cast(16332 As SmallInt), Parm0 = Cast(ItemSite.InvtID As VarChar(30)),
		Parm1 = Cast('' As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemSite ItemSite Full Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	ItemSite.InvtID = @InvtID
/*	ItemSite records must have an associated Inventory Record. */
			And Inventory.InvtID Is Null
	Union
	Select	MsgNbr = Cast(16335 As SmallInt), Parm0 = Cast(ItemSite.InvtID As VarChar(30)),
		Parm1 = Cast(ItemSite.SiteID As VarChar(30)), Parm2 = Cast(Round(ItemSite.TotCost, @BaseDecPl) As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemSite ItemSite Full Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	ItemSite.InvtID = @InvtID
/*	ItemSite records with quantity on hand of zero should also have a total cost of zero. */
			And Round(ItemSite.QtyOnHand, @DecPlQty) = 0
			And Round(ItemSite.TotCost, @BaseDecPl) <> 0
	Union
	Select	MsgNbr = Cast(16336 As SmallInt), Parm0 = Cast(ItemSite.InvtID As VarChar(30)),
		Parm1 = Cast(ItemSite.SiteID As VarChar(30)), Parm2 = Cast('' As VarChar(30)),
		Parm3 = Cast('' As VarChar(30)), Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemSite ItemSite Full Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	ItemSite.InvtID = @InvtID
/*	The Total Cost and Quantity must have the same sign, positive or negative when the total cost is not zero. */
			And Round(ItemSite.TotCost, @BaseDecPl) <> 0
			And Round(ItemSite.QtyOnHand, @DecPlQty) <> 0
			And Sign(ItemSite.TotCost) <> Sign(ItemSite.QtyOnHand)
	Union
	Select	MsgNbr = Cast(16333 As SmallInt), Parm0 = Cast(ItemSite.InvtID As VarChar(30)),
		Parm1 = Cast(ItemSite.SiteID As VarChar(30)), Parm2 = Cast(Round(ItemSite.QtyOnHand, @DecPlQty) As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemSite ItemSite Full Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	ItemSite.InvtID = @InvtID
/*	The quantity on hand can't be negative when the Inventory Setup option to
	Allow Negative Quantities On Hand is disabled.  */
			And @NegQty = 0
			And Round(ItemSite.QtyOnHand, @DecPlQty) < 0
	Union
	Select	MsgNbr = Cast(16364 As SmallInt), Parm0 = Cast(ItemSite.SiteID As VarChar(30)),
		Parm1 = Cast(ItemSite.CpnyID As VarChar(30)), Parm2 = Cast(ItemSite.InvtID As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemSite ItemSite Full Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	ItemSite.InvtID = @InvtID
			And RTrim(ItemSite.CpnyID) <> ''
/*	ItemSite records must have a valid SiteID/CpnyID combination. */
			And Exists (Select * From Site
					Where 	SiteID = ItemSite.SiteID
						And CpnyID = ItemSite.Cpnyid
						And RTrim(CpnyID) <> ''
					Having Count(*) = 0)
	Union
	Select	MsgNbr = Cast(16365 As SmallInt), Parm0 = Cast(ItemSite.InvtID As VarChar(30)),
		Parm1 = Cast(ItemSite.SiteID As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_ItemSite ItemSite Full Join Inventory
			On ItemSite.InvtID = Inventory.InvtID
		Where	ItemSite.InvtID = @InvtID
/*	ItemSite records cannot have a blank CpnyID. */
			And RTrim(ItemSite.CpnyID) = ''


