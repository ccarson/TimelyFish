 Create	Procedure SCM_10400_Upd_ItemBMIHist_Rcvd
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

	Declare	@BMIPTDCostRcvd00 Float, @BMIPTDCostRcvd01 Float, @BMIPTDCostRcvd02 Float, @BMIPTDCostRcvd03 Float, @BMIPTDCostRcvd04 Float,
		@BMIPTDCostRcvd05 Float, @BMIPTDCostRcvd06 Float, @BMIPTDCostRcvd07 Float, @BMIPTDCostRcvd08 Float, @BMIPTDCostRcvd09 Float,
		@BMIPTDCostRcvd10 Float, @BMIPTDCostRcvd11 Float, @BMIPTDCostRcvd12 Float
		Select	@BMIPTDCostRcvd00 = 0, @BMIPTDCostRcvd01 = 0, @BMIPTDCostRcvd02 = 0, @BMIPTDCostRcvd03 = 0, @BMIPTDCostRcvd04 = 0,
		@BMIPTDCostRcvd05 = 0, @BMIPTDCostRcvd06 = 0, @BMIPTDCostRcvd07 = 0, @BMIPTDCostRcvd08 = 0, @BMIPTDCostRcvd09 = 0,
		@BMIPTDCostRcvd10 = 0, @BMIPTDCostRcvd11 = 0, @BMIPTDCostRcvd12 = 0

	If	@Period = 1
	Begin
		Set	@BMIPTDCostRcvd00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@BMIPTDCostRcvd01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@BMIPTDCostRcvd02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@BMIPTDCostRcvd03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@BMIPTDCostRcvd04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@BMIPTDCostRcvd05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@BMIPTDCostRcvd06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@BMIPTDCostRcvd07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@BMIPTDCostRcvd08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@BMIPTDCostRcvd09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@BMIPTDCostRcvd10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@BMIPTDCostRcvd11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@BMIPTDCostRcvd12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemBMIHist
		Set	BMIPTDCostRcvd00 = Round(BMIPTDCostRcvd00 + @BMIPTDCostRcvd00, @BaseDecPl),
			BMIPTDCostRcvd01 = Round(BMIPTDCostRcvd01 + @BMIPTDCostRcvd01, @BaseDecPl),
			BMIPTDCostRcvd02 = Round(BMIPTDCostRcvd02 + @BMIPTDCostRcvd02, @BaseDecPl),
			BMIPTDCostRcvd03 = Round(BMIPTDCostRcvd03 + @BMIPTDCostRcvd03, @BaseDecPl),
			BMIPTDCostRcvd04 = Round(BMIPTDCostRcvd04 + @BMIPTDCostRcvd04, @BaseDecPl),
			BMIPTDCostRcvd05 = Round(BMIPTDCostRcvd05 + @BMIPTDCostRcvd05, @BaseDecPl),
			BMIPTDCostRcvd06 = Round(BMIPTDCostRcvd06 + @BMIPTDCostRcvd06, @BaseDecPl),
			BMIPTDCostRcvd07 = Round(BMIPTDCostRcvd07 + @BMIPTDCostRcvd07, @BaseDecPl),
			BMIPTDCostRcvd08 = Round(BMIPTDCostRcvd08 + @BMIPTDCostRcvd08, @BaseDecPl),
			BMIPTDCostRcvd09 = Round(BMIPTDCostRcvd09 + @BMIPTDCostRcvd09, @BaseDecPl),
			BMIPTDCostRcvd10 = Round(BMIPTDCostRcvd10 + @BMIPTDCostRcvd10, @BaseDecPl),
			BMIPTDCostRcvd11 = Round(BMIPTDCostRcvd11 + @BMIPTDCostRcvd11, @BaseDecPl),
			BMIPTDCostRcvd12 = Round(BMIPTDCostRcvd12 + @BMIPTDCostRcvd12, @BaseDecPl),
			BMIYTDCostRcvd = Round(BMIYTDCostRcvd + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


