 Create	Proc DMG_10990_SysRules_INTran
	@InvtID		VarChar(30),
	@DecPlPrcCst	Int,
	@DecPlQty	Int
As
/*
	This procedure will return a record set containing invalid data found in the INTran
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/

	Set	NoCount On

/*	INTran records must have a valid SiteID/CpnyID combination. */
	Select	MsgNbr = Cast(16364 As SmallInt), Parm0 = Cast(INTran.SiteID As VarChar(30)),
		Parm1 = Cast(INTran.CpnyID As VarChar(30)), Parm2 = Cast(INTran.InvtID As VarChar(30)), Parm3 = Cast(INTran.BatNbr As VarChar(30)),
		Parm4 = Cast(INTran.LineRef As VarChar(30))
		From	INTran
		Where	INTran.InvtID = @InvtID
			And RTrim(INTran.CpnyID) <> ''
			And Exists (Select * From Site
					Where 	SiteID = INTran.SiteID
						And CpnyID = INTran.Cpnyid
						And RTrim(CpnyID) <> ''
					Having Count(*) = 0)
	Union
/*	INTran records cannot have a blank CpnyID. */
	Select	MsgNbr = Cast(16365 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(SiteID As VarChar(30)), Parm2 = Cast(INTran.BatNbr As VarChar(30)), Parm3 = Cast(INTran.LineRef As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	INTran
		Where	InvtID = @InvtID
			And RTrim(CpnyID) = ''
	Union
/*	INTran CpnyID must match the corresponding Batch CpnyID. */
	Select	MsgNbr = Cast(16367 As SmallInt), Parm0 = Cast(INTran.InvtID As VarChar(30)),
		Parm1 = Cast(INTran.BatNbr As VarChar(30)), Parm2 = Cast(INTran.LineRef As VarChar(30)), Parm3 = Cast(INTran.CpnyID As VarChar(30)),
		Parm4 = Cast(Batch.CpnyID As VarChar(30))
		From	INTran Join Batch
			On INTran.BatNbr = Batch.BatNbr
		Where	INTran.InvtID = @InvtID
			And Batch.Module = 'IN'
			And INTran.CpnyID <> Batch.CpnyID
			And RTrim(INTran.CpnyID) <> ''



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_SysRules_INTran] TO [MSDSL]
    AS [dbo];

