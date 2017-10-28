 Create	Procedure SCM_10400_Upd_ItemBMIHist_Issd
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@Period		SmallInt,
	@FiscYr		Char(4),
	@Cost		Float,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@BMIPTDCostIssd00 Float, @BMIPTDCostIssd01 Float, @BMIPTDCostIssd02 Float, @BMIPTDCostIssd03 Float, @BMIPTDCostIssd04 Float,
		@BMIPTDCostIssd05 Float, @BMIPTDCostIssd06 Float, @BMIPTDCostIssd07 Float, @BMIPTDCostIssd08 Float, @BMIPTDCostIssd09 Float,
		@BMIPTDCostIssd10 Float, @BMIPTDCostIssd11 Float, @BMIPTDCostIssd12 Float
		Select	@BMIPTDCostIssd00 = 0, @BMIPTDCostIssd01 = 0, @BMIPTDCostIssd02 = 0, @BMIPTDCostIssd03 = 0, @BMIPTDCostIssd04 = 0,
		@BMIPTDCostIssd05 = 0, @BMIPTDCostIssd06 = 0, @BMIPTDCostIssd07 = 0, @BMIPTDCostIssd08 = 0, @BMIPTDCostIssd09 = 0,
		@BMIPTDCostIssd10 = 0, @BMIPTDCostIssd11 = 0, @BMIPTDCostIssd12 = 0

	If	@Period = 1
	Begin
		Set	@BMIPTDCostIssd00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@BMIPTDCostIssd01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@BMIPTDCostIssd02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@BMIPTDCostIssd03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@BMIPTDCostIssd04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@BMIPTDCostIssd05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@BMIPTDCostIssd06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@BMIPTDCostIssd07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@BMIPTDCostIssd08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@BMIPTDCostIssd09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@BMIPTDCostIssd10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@BMIPTDCostIssd11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@BMIPTDCostIssd12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemBMIHist
		Set	BMIPTDCostIssd00 = Round(BMIPTDCostIssd00 + @BMIPTDCostIssd00, @BaseDecPl),
			BMIPTDCostIssd01 = Round(BMIPTDCostIssd01 + @BMIPTDCostIssd01, @BaseDecPl),
			BMIPTDCostIssd02 = Round(BMIPTDCostIssd02 + @BMIPTDCostIssd02, @BaseDecPl),
			BMIPTDCostIssd03 = Round(BMIPTDCostIssd03 + @BMIPTDCostIssd03, @BaseDecPl),
			BMIPTDCostIssd04 = Round(BMIPTDCostIssd04 + @BMIPTDCostIssd04, @BaseDecPl),
			BMIPTDCostIssd05 = Round(BMIPTDCostIssd05 + @BMIPTDCostIssd05, @BaseDecPl),
			BMIPTDCostIssd06 = Round(BMIPTDCostIssd06 + @BMIPTDCostIssd06, @BaseDecPl),
			BMIPTDCostIssd07 = Round(BMIPTDCostIssd07 + @BMIPTDCostIssd07, @BaseDecPl),
			BMIPTDCostIssd08 = Round(BMIPTDCostIssd08 + @BMIPTDCostIssd08, @BaseDecPl),
			BMIPTDCostIssd09 = Round(BMIPTDCostIssd09 + @BMIPTDCostIssd09, @BaseDecPl),
			BMIPTDCostIssd10 = Round(BMIPTDCostIssd10 + @BMIPTDCostIssd10, @BaseDecPl),
			BMIPTDCostIssd11 = Round(BMIPTDCostIssd11 + @BMIPTDCostIssd11, @BaseDecPl),
			BMIPTDCostIssd12 = Round(BMIPTDCostIssd12 + @BMIPTDCostIssd12, @BaseDecPl),
			BMIYTDCostIssd = Round(BMIYTDCostIssd + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


