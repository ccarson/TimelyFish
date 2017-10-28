 Create	Proc DMG_10990_SysRules_LotSerT
	@InvtID		VarChar(30)
As
/*
	This procedure will return a record set containing invalid data found in the LotSerT
	table.  Each occurance of invalid data will be returned as a row in the result set.
*/
	Set	NoCount On

/*	LotSerT records must have a valid SiteID/CpnyID combination. */
	Select	MsgNbr = Cast(16364 As SmallInt), Parm0 = Cast(SiteID As VarChar(30)),
		Parm1 = Cast(CpnyID As VarChar(30)), Parm2 = Cast(InvtID As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	LotSerT
		Where	InvtID = @InvtID
			And Exists (Select * From Site
					Where 	SiteID = LotSerT.SiteID
						And CpnyID = LotSerT.Cpnyid
					Having Count(*) = 0)
	Union
/*	LotSerT records cannot have a blank CpnyID. */
	Select	MsgNbr = Cast(16365 As SmallInt), Parm0 = Cast(InvtID As VarChar(30)),
		Parm1 = Cast(SiteID As VarChar(30)), Parm2 = Cast('' As VarChar(30)), Parm3 = Cast('' As VarChar(30)),
		Parm4 = Cast('' As VarChar(30))
		From	LotSerT
		Where	InvtID = @InvtID
			And RTrim(CpnyID) = ''


