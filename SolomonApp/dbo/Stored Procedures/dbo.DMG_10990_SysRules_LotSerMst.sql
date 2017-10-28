 Create	Proc DMG_10990_SysRules_LotSerMst
	@InvtID		VarChar(30),
	@BaseDecPl	Int,
	@BMIDecPl	Int,
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As
/*
	This procedure will return a record set containing invalid data found in the LotSerMst
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

	Select	MsgNbr = Cast(16332 As SmallInt), Parm0 = Cast(LotSerMst.InvtID As VarChar(30)),
		Parm1 = Cast('' As VarChar(30)), Parm2 = Cast('' As VarChar(30)),
		Parm3 = Cast('' As VarChar(30)), Parm4 = Cast('' As VarChar(30))
		From	IN10990_LotSerMst LotSerMst Full Join Inventory
			On LotSerMst.InvtID = Inventory.InvtID
		Where	LotSerMst.InvtID = @InvtID
			And Inventory.InvtID Is Null
/* Lot or Serial Numbers are assigned when used from Inventory.*/
	Union
	Select	MsgNbr = Cast(16341 As SmallInt), Parm0 = Cast(LotSerMst.InvtID As VarChar(30)),
		Parm1 = Cast(LotSerMst.SiteID As VarChar(30)), Parm2 = Cast(LotSerMst.WhseLoc As VarChar(30)),
		Parm3 = Cast(LotSerMst.LotSerNbr As VarChar(30)), Parm4 = Cast('' As VarChar(30))
		From	IN10990_LotSerMst LotSerMst Full Join Inventory
			On LotSerMst.InvtID = Inventory.InvtID
		Where	LotSerMst.InvtID = @InvtID
			And Inventory.SerAssign = 'U'
/* Inventory Item is Lot or Serial Controlled.*/
			And Inventory.LotSerTrack In ('LI', 'SI')
/* Quantity On Hand for assignment 'When Used' should always equal zero.*/
			And Round(LotSerMst.QtyOnHand, @DecPlQty) <> 0
/* Lot or Serial Numbers are assigned when Inventory is received.*/
	Union
	Select	MsgNbr = Cast(16340 As SmallInt), Parm0 = Cast(LotSerMst.InvtID As VarChar(30)),
		Parm1 = Cast(LotSerMst.SiteID As VarChar(30)), Parm2 = Cast(LotSerMst.WhseLoc As VarChar(30)),
		Parm3 = Cast(LotSerMst.LotSerNbr As VarChar(30)), Parm4 = Cast('' As VarChar(30))
		From	IN10990_LotSerMst LotSerMst Full Join Inventory
			On LotSerMst.InvtID = Inventory.InvtID
		Where	LotSerMst.InvtID = @InvtID
			And Inventory.SerAssign = 'R'
/* Inventory Item is Lot Controlled.*/
			And Inventory.LotSerTrack = 'LI'
/* Quantity On Hand for assignment 'When Received' Lot Controlled Items should never be less than zero.*/
			And Round(LotSerMst.QtyOnHand, @DecPlQty) < 0
/* Inventory Item is Serial Controlled.*/
	Union
	Select	MsgNbr = Cast(16342 As SmallInt), Parm0 = Cast(LotSerMst.InvtID As VarChar(30)),
		Parm1 = Cast(LotSerMst.SiteID As VarChar(30)), Parm2 = Cast(LotSerMst.WhseLoc As VarChar(30)),
		Parm3 = Cast(LotSerMst.LotSerNbr As VarChar(30)), Parm4 = Cast(Round(LotSerMst.QtyOnHand, @DecPlQty) As VarChar(30))
		From	IN10990_LotSerMst LotSerMst Full Join Inventory
			On LotSerMst.InvtID = Inventory.InvtID
		Where	LotSerMst.InvtID = @InvtID
			And Inventory.LotSerTrack = 'SI'
/* Quantity On Hand for assignment 'When Received' Serial Controlled Items can only equal one (1) or zero (0).*/
			And Round(LotSerMst.QtyOnHand, @DecPlQty) Not In (0, 1)


