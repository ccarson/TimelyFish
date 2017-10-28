 Create	Procedure SCM_10400_Upd_ItemHist_TrsfrIn
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

	Declare	@PTDCostTrsfrIn00 Float, @PTDCostTrsfrIn01 Float, @PTDCostTrsfrIn02 Float, @PTDCostTrsfrIn03 Float, @PTDCostTrsfrIn04 Float,
		@PTDCostTrsfrIn05 Float, @PTDCostTrsfrIn06 Float, @PTDCostTrsfrIn07 Float, @PTDCostTrsfrIn08 Float, @PTDCostTrsfrIn09 Float,
		@PTDCostTrsfrIn10 Float, @PTDCostTrsfrIn11 Float, @PTDCostTrsfrIn12 Float
		Select	@PTDCostTrsfrIn00 = 0, @PTDCostTrsfrIn01 = 0, @PTDCostTrsfrIn02 = 0, @PTDCostTrsfrIn03 = 0, @PTDCostTrsfrIn04 = 0,
		@PTDCostTrsfrIn05 = 0, @PTDCostTrsfrIn06 = 0, @PTDCostTrsfrIn07 = 0, @PTDCostTrsfrIn08 = 0, @PTDCostTrsfrIn09 = 0,
		@PTDCostTrsfrIn10 = 0, @PTDCostTrsfrIn11 = 0, @PTDCostTrsfrIn12 = 0

	If	@Period = 1
	Begin
		Set	@PTDCostTrsfrIn00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDCostTrsfrIn01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDCostTrsfrIn02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDCostTrsfrIn03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDCostTrsfrIn04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDCostTrsfrIn05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDCostTrsfrIn06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDCostTrsfrIn07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDCostTrsfrIn08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDCostTrsfrIn09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDCostTrsfrIn10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDCostTrsfrIn11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDCostTrsfrIn12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDCostTrsfrIn00 = Round(PTDCostTrsfrIn00 + @PTDCostTrsfrIn00, @BaseDecPl),
			PTDCostTrsfrIn01 = Round(PTDCostTrsfrIn01 + @PTDCostTrsfrIn01, @BaseDecPl),
			PTDCostTrsfrIn02 = Round(PTDCostTrsfrIn02 + @PTDCostTrsfrIn02, @BaseDecPl),
			PTDCostTrsfrIn03 = Round(PTDCostTrsfrIn03 + @PTDCostTrsfrIn03, @BaseDecPl),
			PTDCostTrsfrIn04 = Round(PTDCostTrsfrIn04 + @PTDCostTrsfrIn04, @BaseDecPl),
			PTDCostTrsfrIn05 = Round(PTDCostTrsfrIn05 + @PTDCostTrsfrIn05, @BaseDecPl),
			PTDCostTrsfrIn06 = Round(PTDCostTrsfrIn06 + @PTDCostTrsfrIn06, @BaseDecPl),
			PTDCostTrsfrIn07 = Round(PTDCostTrsfrIn07 + @PTDCostTrsfrIn07, @BaseDecPl),
			PTDCostTrsfrIn08 = Round(PTDCostTrsfrIn08 + @PTDCostTrsfrIn08, @BaseDecPl),
			PTDCostTrsfrIn09 = Round(PTDCostTrsfrIn09 + @PTDCostTrsfrIn09, @BaseDecPl),
			PTDCostTrsfrIn10 = Round(PTDCostTrsfrIn10 + @PTDCostTrsfrIn10, @BaseDecPl),
			PTDCostTrsfrIn11 = Round(PTDCostTrsfrIn11 + @PTDCostTrsfrIn11, @BaseDecPl),
			PTDCostTrsfrIn12 = Round(PTDCostTrsfrIn12 + @PTDCostTrsfrIn12, @BaseDecPl),
			YTDCostTrsfrIn = Round(YTDCostTrsfrIn + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ItemHist_TrsfrIn] TO [MSDSL]
    AS [dbo];

