 Create	Proc DMG_10990_SysRules_Location
	@InvtID	VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As
/*
	This procedure will return a record set containing invalid data found in the Location
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

	Declare	@NegQty		SmallInt
	Select	@NegQty = NegQty
		From	INSetup

	Select	MsgNbr = Cast(16332 As SmallInt), Parm0 = Cast(Location.InvtID As VarChar(30)),
		Parm1 = Cast('' As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_Location Location Full Join Inventory
			On Location.InvtID = Inventory.InvtID
		Where	Location.InvtID = @InvtID
			And Inventory.InvtID Is Null
/*	The option to Allow Negative Quantities On Hand is disabled. */
	Union
	Select	MsgNbr = Cast(16334 As SmallInt), Parm0 = Cast(Location.InvtID As VarChar(30)),
		Parm1 = Cast( Location.SiteID As VarChar(30)), Parm2 = Cast(Location.WhseLoc As VarChar(30)),
		Parm3 = Cast(Round(Location.QtyOnHand, @DecPlQty) As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	IN10990_Location Location Full Join Inventory
			On Location.InvtID = Inventory.InvtID
		Where	Location.InvtID = @InvtID
			And @NegQty = 0
/* Quantity On Hand should never be less than zero when negative Quantities On Hand are not allowed. */
			And Round(Location.QtyOnHand, @DecPlQty) < 0



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_SysRules_Location] TO [MSDSL]
    AS [dbo];

