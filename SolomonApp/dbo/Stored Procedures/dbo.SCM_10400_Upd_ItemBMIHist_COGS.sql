 Create	Procedure SCM_10400_Upd_ItemBMIHist_COGS
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

	Declare	@BMIPTDCOGS00 Float, @BMIPTDCOGS01 Float, @BMIPTDCOGS02 Float, @BMIPTDCOGS03 Float, @BMIPTDCOGS04 Float,
		@BMIPTDCOGS05 Float, @BMIPTDCOGS06 Float, @BMIPTDCOGS07 Float, @BMIPTDCOGS08 Float, @BMIPTDCOGS09 Float,
		@BMIPTDCOGS10 Float, @BMIPTDCOGS11 Float, @BMIPTDCOGS12 Float
		Select	@BMIPTDCOGS00 = 0, @BMIPTDCOGS01 = 0, @BMIPTDCOGS02 = 0, @BMIPTDCOGS03 = 0, @BMIPTDCOGS04 = 0,
		@BMIPTDCOGS05 = 0, @BMIPTDCOGS06 = 0, @BMIPTDCOGS07 = 0, @BMIPTDCOGS08 = 0, @BMIPTDCOGS09 = 0,
		@BMIPTDCOGS10 = 0, @BMIPTDCOGS11 = 0, @BMIPTDCOGS12 = 0

	If	@Period = 1
	Begin
		Set	@BMIPTDCOGS00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@BMIPTDCOGS01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@BMIPTDCOGS02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@BMIPTDCOGS03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@BMIPTDCOGS04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@BMIPTDCOGS05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@BMIPTDCOGS06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@BMIPTDCOGS07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@BMIPTDCOGS08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@BMIPTDCOGS09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@BMIPTDCOGS10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@BMIPTDCOGS11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@BMIPTDCOGS12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemBMIHist
		Set	BMIPTDCOGS00 = Round(BMIPTDCOGS00 + @BMIPTDCOGS00, @BaseDecPl),
			BMIPTDCOGS01 = Round(BMIPTDCOGS01 + @BMIPTDCOGS01, @BaseDecPl),
			BMIPTDCOGS02 = Round(BMIPTDCOGS02 + @BMIPTDCOGS02, @BaseDecPl),
			BMIPTDCOGS03 = Round(BMIPTDCOGS03 + @BMIPTDCOGS03, @BaseDecPl),
			BMIPTDCOGS04 = Round(BMIPTDCOGS04 + @BMIPTDCOGS04, @BaseDecPl),
			BMIPTDCOGS05 = Round(BMIPTDCOGS05 + @BMIPTDCOGS05, @BaseDecPl),
			BMIPTDCOGS06 = Round(BMIPTDCOGS06 + @BMIPTDCOGS06, @BaseDecPl),
			BMIPTDCOGS07 = Round(BMIPTDCOGS07 + @BMIPTDCOGS07, @BaseDecPl),
			BMIPTDCOGS08 = Round(BMIPTDCOGS08 + @BMIPTDCOGS08, @BaseDecPl),
			BMIPTDCOGS09 = Round(BMIPTDCOGS09 + @BMIPTDCOGS09, @BaseDecPl),
			BMIPTDCOGS10 = Round(BMIPTDCOGS10 + @BMIPTDCOGS10, @BaseDecPl),
			BMIPTDCOGS11 = Round(BMIPTDCOGS11 + @BMIPTDCOGS11, @BaseDecPl),
			BMIPTDCOGS12 = Round(BMIPTDCOGS12 + @BMIPTDCOGS12, @BaseDecPl),
			BMIYTDCOGS = Round(BMIYTDCOGS + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


