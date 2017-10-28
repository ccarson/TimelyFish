 Create	Procedure SCM_10400_Upd_ItemHist_Rcvd
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

	Declare	@PTDCostRcvd00 Float, @PTDCostRcvd01 Float, @PTDCostRcvd02 Float, @PTDCostRcvd03 Float, @PTDCostRcvd04 Float,
		@PTDCostRcvd05 Float, @PTDCostRcvd06 Float, @PTDCostRcvd07 Float, @PTDCostRcvd08 Float, @PTDCostRcvd09 Float,
		@PTDCostRcvd10 Float, @PTDCostRcvd11 Float, @PTDCostRcvd12 Float
		Select	@PTDCostRcvd00 = 0, @PTDCostRcvd01 = 0, @PTDCostRcvd02 = 0, @PTDCostRcvd03 = 0, @PTDCostRcvd04 = 0,
		@PTDCostRcvd05 = 0, @PTDCostRcvd06 = 0, @PTDCostRcvd07 = 0, @PTDCostRcvd08 = 0, @PTDCostRcvd09 = 0,
		@PTDCostRcvd10 = 0, @PTDCostRcvd11 = 0, @PTDCostRcvd12 = 0

	If	@Period = 1
	Begin
		Set	@PTDCostRcvd00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDCostRcvd01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDCostRcvd02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDCostRcvd03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDCostRcvd04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDCostRcvd05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDCostRcvd06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDCostRcvd07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDCostRcvd08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDCostRcvd09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDCostRcvd10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDCostRcvd11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDCostRcvd12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDCostRcvd00 = Round(PTDCostRcvd00 + @PTDCostRcvd00, @BaseDecPl),
			PTDCostRcvd01 = Round(PTDCostRcvd01 + @PTDCostRcvd01, @BaseDecPl),
			PTDCostRcvd02 = Round(PTDCostRcvd02 + @PTDCostRcvd02, @BaseDecPl),
			PTDCostRcvd03 = Round(PTDCostRcvd03 + @PTDCostRcvd03, @BaseDecPl),
			PTDCostRcvd04 = Round(PTDCostRcvd04 + @PTDCostRcvd04, @BaseDecPl),
			PTDCostRcvd05 = Round(PTDCostRcvd05 + @PTDCostRcvd05, @BaseDecPl),
			PTDCostRcvd06 = Round(PTDCostRcvd06 + @PTDCostRcvd06, @BaseDecPl),
			PTDCostRcvd07 = Round(PTDCostRcvd07 + @PTDCostRcvd07, @BaseDecPl),
			PTDCostRcvd08 = Round(PTDCostRcvd08 + @PTDCostRcvd08, @BaseDecPl),
			PTDCostRcvd09 = Round(PTDCostRcvd09 + @PTDCostRcvd09, @BaseDecPl),
			PTDCostRcvd10 = Round(PTDCostRcvd10 + @PTDCostRcvd10, @BaseDecPl),
			PTDCostRcvd11 = Round(PTDCostRcvd11 + @PTDCostRcvd11, @BaseDecPl),
			PTDCostRcvd12 = Round(PTDCostRcvd12 + @PTDCostRcvd12, @BaseDecPl),
			YTDCostRcvd = Round(YTDCostRcvd + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ItemHist_Rcvd] TO [MSDSL]
    AS [dbo];

