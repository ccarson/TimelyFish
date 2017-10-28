 Create	Proc DMG_10990_Populate_IN10990_Check
	@UserName	VarChar(10),
	@InvtIDParm	VARCHAR (30)

As
/*
	This procedure will populate the IN10990_Check table with records from INTran and LotSerT
	formatted within the vp_INCheck view.
	*/
	Set	NoCount On

	Insert	Into IN10990_Check
		(BatNbr, BMITotCost, CpnyID, Crtd_DateTime, Crtd_Prog,
		Crtd_User, CuryMultDiv, InvtID, LayerType, LineRef,
		LotSerNbr, LUpd_DateTime, LUpd_Prog, LUpd_User, Qty,
		Rate, RcptDate, RcptNbr, RefNbr, SiteID,
		SpecificCostID, TotCost, TranDate, TranDesc, TranType,
		UnitCost, ValMthd, WhseLoc)
	Select	BatNbr, BMITotCost, CpnyID, GetDate(), '10990',
		@UserName, CuryMultDiv, InvtID, LayerType, LineRef,
		LotSerNbr, GetDate(), '10990', @UserName, Qty,
		Rate,
		RcptDate = Cast(Cast(Month(RcptDate) As VarChar(4)) + '/'
				+ Cast(Day(RcptDate) As VarChar(4)) + '/'
				+ Cast(Year(RcptDate) As VarChar(4)) As SmallDateTime),
		RcptNbr, RefNbr, SiteID,
		SpecificCostID,
		TotCost = Case When TotCost Is NULL
				Then 0
				Else TotCost
			  End,
		TranDate, TranDesc, TranType,
		UnitCost, ValMthd, WhseLoc
		From	vp_INCheck
		WHERE vp_INCheck.InvtID LIKE @InvtIDParm



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DMG_10990_Populate_IN10990_Check] TO [MSDSL]
    AS [dbo];

