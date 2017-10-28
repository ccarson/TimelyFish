 Create	Procedure SCM_10400_Upd_ItemHist_TrsfrOut
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

	Declare	@PTDCostTrsfrOut00 Float, @PTDCostTrsfrOut01 Float, @PTDCostTrsfrOut02 Float, @PTDCostTrsfrOut03 Float, @PTDCostTrsfrOut04 Float,
		@PTDCostTrsfrOut05 Float, @PTDCostTrsfrOut06 Float, @PTDCostTrsfrOut07 Float, @PTDCostTrsfrOut08 Float, @PTDCostTrsfrOut09 Float,
		@PTDCostTrsfrOut10 Float, @PTDCostTrsfrOut11 Float, @PTDCostTrsfrOut12 Float
		Select	@PTDCostTrsfrOut00 = 0, @PTDCostTrsfrOut01 = 0, @PTDCostTrsfrOut02 = 0, @PTDCostTrsfrOut03 = 0, @PTDCostTrsfrOut04 = 0,
		@PTDCostTrsfrOut05 = 0, @PTDCostTrsfrOut06 = 0, @PTDCostTrsfrOut07 = 0, @PTDCostTrsfrOut08 = 0, @PTDCostTrsfrOut09 = 0,
		@PTDCostTrsfrOut10 = 0, @PTDCostTrsfrOut11 = 0, @PTDCostTrsfrOut12 = 0

	If	@Period = 1
	Begin
		Set	@PTDCostTrsfrOut00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDCostTrsfrOut01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDCostTrsfrOut02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDCostTrsfrOut03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDCostTrsfrOut04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDCostTrsfrOut05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDCostTrsfrOut06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDCostTrsfrOut07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDCostTrsfrOut08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDCostTrsfrOut09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDCostTrsfrOut10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDCostTrsfrOut11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDCostTrsfrOut12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDCostTrsfrOut00 = Round(PTDCostTrsfrOut00 + @PTDCostTrsfrOut00, @BaseDecPl),
			PTDCostTrsfrOut01 = Round(PTDCostTrsfrOut01 + @PTDCostTrsfrOut01, @BaseDecPl),
			PTDCostTrsfrOut02 = Round(PTDCostTrsfrOut02 + @PTDCostTrsfrOut02, @BaseDecPl),
			PTDCostTrsfrOut03 = Round(PTDCostTrsfrOut03 + @PTDCostTrsfrOut03, @BaseDecPl),
			PTDCostTrsfrOut04 = Round(PTDCostTrsfrOut04 + @PTDCostTrsfrOut04, @BaseDecPl),
			PTDCostTrsfrOut05 = Round(PTDCostTrsfrOut05 + @PTDCostTrsfrOut05, @BaseDecPl),
			PTDCostTrsfrOut06 = Round(PTDCostTrsfrOut06 + @PTDCostTrsfrOut06, @BaseDecPl),
			PTDCostTrsfrOut07 = Round(PTDCostTrsfrOut07 + @PTDCostTrsfrOut07, @BaseDecPl),
			PTDCostTrsfrOut08 = Round(PTDCostTrsfrOut08 + @PTDCostTrsfrOut08, @BaseDecPl),
			PTDCostTrsfrOut09 = Round(PTDCostTrsfrOut09 + @PTDCostTrsfrOut09, @BaseDecPl),
			PTDCostTrsfrOut10 = Round(PTDCostTrsfrOut10 + @PTDCostTrsfrOut10, @BaseDecPl),
			PTDCostTrsfrOut11 = Round(PTDCostTrsfrOut11 + @PTDCostTrsfrOut11, @BaseDecPl),
			PTDCostTrsfrOut12 = Round(PTDCostTrsfrOut12 + @PTDCostTrsfrOut12, @BaseDecPl),
			YTDCostTrsfrOut = Round(YTDCostTrsfrOut + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ItemHist_TrsfrOut] TO [MSDSL]
    AS [dbo];

