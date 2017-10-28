 Create	Procedure SCM_10400_Upd_ItemBMIHist_Adjd
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

	Declare	@BMIPTDCostAdjd00 Float, @BMIPTDCostAdjd01 Float, @BMIPTDCostAdjd02 Float, @BMIPTDCostAdjd03 Float, @BMIPTDCostAdjd04 Float,
		@BMIPTDCostAdjd05 Float, @BMIPTDCostAdjd06 Float, @BMIPTDCostAdjd07 Float, @BMIPTDCostAdjd08 Float, @BMIPTDCostAdjd09 Float,
		@BMIPTDCostAdjd10 Float, @BMIPTDCostAdjd11 Float, @BMIPTDCostAdjd12 Float
		Select	@BMIPTDCostAdjd00 = 0, @BMIPTDCostAdjd01 = 0, @BMIPTDCostAdjd02 = 0, @BMIPTDCostAdjd03 = 0, @BMIPTDCostAdjd04 = 0,
		@BMIPTDCostAdjd05 = 0, @BMIPTDCostAdjd06 = 0, @BMIPTDCostAdjd07 = 0, @BMIPTDCostAdjd08 = 0, @BMIPTDCostAdjd09 = 0,
		@BMIPTDCostAdjd10 = 0, @BMIPTDCostAdjd11 = 0, @BMIPTDCostAdjd12 = 0

	If	@Period = 1
	Begin
		Set	@BMIPTDCostAdjd00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@BMIPTDCostAdjd01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@BMIPTDCostAdjd02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@BMIPTDCostAdjd03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@BMIPTDCostAdjd04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@BMIPTDCostAdjd05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@BMIPTDCostAdjd06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@BMIPTDCostAdjd07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@BMIPTDCostAdjd08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@BMIPTDCostAdjd09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@BMIPTDCostAdjd10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@BMIPTDCostAdjd11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@BMIPTDCostAdjd12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemBMIHist
		Set	BMIPTDCostAdjd00 = Round(BMIPTDCostAdjd00 + @BMIPTDCostAdjd00, @BaseDecPl),
			BMIPTDCostAdjd01 = Round(BMIPTDCostAdjd01 + @BMIPTDCostAdjd01, @BaseDecPl),
			BMIPTDCostAdjd02 = Round(BMIPTDCostAdjd02 + @BMIPTDCostAdjd02, @BaseDecPl),
			BMIPTDCostAdjd03 = Round(BMIPTDCostAdjd03 + @BMIPTDCostAdjd03, @BaseDecPl),
			BMIPTDCostAdjd04 = Round(BMIPTDCostAdjd04 + @BMIPTDCostAdjd04, @BaseDecPl),
			BMIPTDCostAdjd05 = Round(BMIPTDCostAdjd05 + @BMIPTDCostAdjd05, @BaseDecPl),
			BMIPTDCostAdjd06 = Round(BMIPTDCostAdjd06 + @BMIPTDCostAdjd06, @BaseDecPl),
			BMIPTDCostAdjd07 = Round(BMIPTDCostAdjd07 + @BMIPTDCostAdjd07, @BaseDecPl),
			BMIPTDCostAdjd08 = Round(BMIPTDCostAdjd08 + @BMIPTDCostAdjd08, @BaseDecPl),
			BMIPTDCostAdjd09 = Round(BMIPTDCostAdjd09 + @BMIPTDCostAdjd09, @BaseDecPl),
			BMIPTDCostAdjd10 = Round(BMIPTDCostAdjd10 + @BMIPTDCostAdjd10, @BaseDecPl),
			BMIPTDCostAdjd11 = Round(BMIPTDCostAdjd11 + @BMIPTDCostAdjd11, @BaseDecPl),
			BMIPTDCostAdjd12 = Round(BMIPTDCostAdjd12 + @BMIPTDCostAdjd12, @BaseDecPl),
			BMIYTDCostAdjd = Round(BMIYTDCostAdjd + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


