 Create	Proc DMG_10990_SysRules_Inventory
	@InvtID	VarChar(30)
As
/*
	This procedure will return a record set containing invalid data found in the Inventory
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

	Select	MsgNbr = Cast(16324 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(TranStatusCode As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	Inventory
		Where	InvtID = @InvtID
/*	Validate transaction status codes. */
			And TranStatusCode Not In ('AC', 'DE', 'IN', 'NP', 'NU', 'OH')
	Union
	Select	MsgNbr = Cast(16325 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(LotSerTrack As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	Inventory
		Where	InvtID = @InvtID
/*	Only check when transaction status code is not set to 'Delete', 'Inactive' or 'No Usage'. */
			And TranStatusCode Not In ('DE', 'IN', 'NU')
/*	Validate Lot Serial Tracking Options */
			And LotSerTrack Not In ('LI', 'SI', 'NN')
	Union
	Select	MsgNbr = Cast(16326 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(SerAssign As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	Inventory
		Where	InvtID = @InvtID
/*	Only check when transaction status code is not set to 'Delete', 'Inactive' or 'No Usage'. */
			And TranStatusCode Not In ('DE', 'IN', 'NU')
/*	Validate Assignment Options */
			And SerAssign Not In ('R', 'U', '')
	Union
	Select	MsgNbr = Cast(16327 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(ValMthd As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	Inventory
		Where	InvtID = @InvtID
/*	Only check when transaction status code is not set to 'Delete', 'Inactive' or 'No Usage'. */
			And TranStatusCode Not In ('DE', 'IN', 'NU')
/*	Validate Valuation Methods */
			And ValMthd Not In ('A', 'F', 'L', 'S', 'T', 'U')
	Union
	Select	MsgNbr = Cast(16328 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(SerAssign As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
 		From	Inventory
		Where	InvtID = @InvtID
/*	Only check when transaction status code is not set to 'Delete', 'Inactive' or 'No Usage'. */
			And TranStatusCode Not In ('DE', 'IN', 'NU')
/*	Validate that all Lot or Serial Controlled items have a valid assignment method. */
			And LotSerTrack In ('LI', 'SI')
			And SerAssign Not In ('R', 'U')
	Union
	Select	MsgNbr = Cast(16329 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast('' As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	Inventory
		Where	InvtID = @InvtID
/*	Only check when transaction status code is not set to 'Delete', 'Inactive' or 'No Usage'. */
			And TranStatusCode Not In ('DE', 'IN', 'NU')
/*	Validate that a Lot or Serial Controlled item is not flagged as a non-stock item. */
			And LotSerTrack In ('LI', 'SI')
			And StkItem = 0
	Union
	Select	MsgNbr = Cast(16330 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast('' As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	Inventory
		Where	InvtID = @InvtID
/*	Only check when transaction status code is not set to 'Delete', 'Inactive' or 'No Usage'. */
			And TranStatusCode Not In ('DE', 'IN', 'NU')
/*	Validate that only Standard Cost or User Specified valuation method items are non-stock. */
			And ValMthd Not In ('T', 'U')
			And StkItem = 0


