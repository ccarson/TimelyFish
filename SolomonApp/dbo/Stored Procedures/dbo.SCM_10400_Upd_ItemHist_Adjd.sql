 Create	Procedure SCM_10400_Upd_ItemHist_Adjd
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

	Declare	@PTDCostAdjd00 Float, @PTDCostAdjd01 Float, @PTDCostAdjd02 Float, @PTDCostAdjd03 Float, @PTDCostAdjd04 Float,
		@PTDCostAdjd05 Float, @PTDCostAdjd06 Float, @PTDCostAdjd07 Float, @PTDCostAdjd08 Float, @PTDCostAdjd09 Float,
		@PTDCostAdjd10 Float, @PTDCostAdjd11 Float, @PTDCostAdjd12 Float
		Select	@PTDCostAdjd00 = 0, @PTDCostAdjd01 = 0, @PTDCostAdjd02 = 0, @PTDCostAdjd03 = 0, @PTDCostAdjd04 = 0,
		@PTDCostAdjd05 = 0, @PTDCostAdjd06 = 0, @PTDCostAdjd07 = 0, @PTDCostAdjd08 = 0, @PTDCostAdjd09 = 0,
		@PTDCostAdjd10 = 0, @PTDCostAdjd11 = 0, @PTDCostAdjd12 = 0

	If	@Period = 1
	Begin
		Set	@PTDCostAdjd00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDCostAdjd01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDCostAdjd02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDCostAdjd03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDCostAdjd04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDCostAdjd05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDCostAdjd06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDCostAdjd07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDCostAdjd08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDCostAdjd09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDCostAdjd10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDCostAdjd11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDCostAdjd12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDCostAdjd00 = Round(PTDCostAdjd00 + @PTDCostAdjd00, @BaseDecPl),
			PTDCostAdjd01 = Round(PTDCostAdjd01 + @PTDCostAdjd01, @BaseDecPl),
			PTDCostAdjd02 = Round(PTDCostAdjd02 + @PTDCostAdjd02, @BaseDecPl),
			PTDCostAdjd03 = Round(PTDCostAdjd03 + @PTDCostAdjd03, @BaseDecPl),
			PTDCostAdjd04 = Round(PTDCostAdjd04 + @PTDCostAdjd04, @BaseDecPl),
			PTDCostAdjd05 = Round(PTDCostAdjd05 + @PTDCostAdjd05, @BaseDecPl),
			PTDCostAdjd06 = Round(PTDCostAdjd06 + @PTDCostAdjd06, @BaseDecPl),
			PTDCostAdjd07 = Round(PTDCostAdjd07 + @PTDCostAdjd07, @BaseDecPl),
			PTDCostAdjd08 = Round(PTDCostAdjd08 + @PTDCostAdjd08, @BaseDecPl),
			PTDCostAdjd09 = Round(PTDCostAdjd09 + @PTDCostAdjd09, @BaseDecPl),
			PTDCostAdjd10 = Round(PTDCostAdjd10 + @PTDCostAdjd10, @BaseDecPl),
			PTDCostAdjd11 = Round(PTDCostAdjd11 + @PTDCostAdjd11, @BaseDecPl),
			PTDCostAdjd12 = Round(PTDCostAdjd12 + @PTDCostAdjd12, @BaseDecPl),
			YTDCostAdjd = Round(YTDCostAdjd + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


