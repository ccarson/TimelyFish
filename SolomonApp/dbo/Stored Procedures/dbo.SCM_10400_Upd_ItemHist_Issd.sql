 Create	Procedure SCM_10400_Upd_ItemHist_Issd
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

	Declare	@PTDCostIssd00 Float, @PTDCostIssd01 Float, @PTDCostIssd02 Float, @PTDCostIssd03 Float, @PTDCostIssd04 Float,
		@PTDCostIssd05 Float, @PTDCostIssd06 Float, @PTDCostIssd07 Float, @PTDCostIssd08 Float, @PTDCostIssd09 Float,
		@PTDCostIssd10 Float, @PTDCostIssd11 Float, @PTDCostIssd12 Float
		Select	@PTDCostIssd00 = 0, @PTDCostIssd01 = 0, @PTDCostIssd02 = 0, @PTDCostIssd03 = 0, @PTDCostIssd04 = 0,
		@PTDCostIssd05 = 0, @PTDCostIssd06 = 0, @PTDCostIssd07 = 0, @PTDCostIssd08 = 0, @PTDCostIssd09 = 0,
		@PTDCostIssd10 = 0, @PTDCostIssd11 = 0, @PTDCostIssd12 = 0

	If	@Period = 1
	Begin
		Set	@PTDCostIssd00 = @Cost
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDCostIssd01 = @Cost
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDCostIssd02 = @Cost
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDCostIssd03 = @Cost
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDCostIssd04 = @Cost
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDCostIssd05 = @Cost
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDCostIssd06 = @Cost
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDCostIssd07 = @Cost
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDCostIssd08 = @Cost
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDCostIssd09 = @Cost
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDCostIssd10 = @Cost
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDCostIssd11 = @Cost
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDCostIssd12 = @Cost
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDCostIssd00 = Round(PTDCostIssd00 + @PTDCostIssd00, @BaseDecPl),
			PTDCostIssd01 = Round(PTDCostIssd01 + @PTDCostIssd01, @BaseDecPl),
			PTDCostIssd02 = Round(PTDCostIssd02 + @PTDCostIssd02, @BaseDecPl),
			PTDCostIssd03 = Round(PTDCostIssd03 + @PTDCostIssd03, @BaseDecPl),
			PTDCostIssd04 = Round(PTDCostIssd04 + @PTDCostIssd04, @BaseDecPl),
			PTDCostIssd05 = Round(PTDCostIssd05 + @PTDCostIssd05, @BaseDecPl),
			PTDCostIssd06 = Round(PTDCostIssd06 + @PTDCostIssd06, @BaseDecPl),
			PTDCostIssd07 = Round(PTDCostIssd07 + @PTDCostIssd07, @BaseDecPl),
			PTDCostIssd08 = Round(PTDCostIssd08 + @PTDCostIssd08, @BaseDecPl),
			PTDCostIssd09 = Round(PTDCostIssd09 + @PTDCostIssd09, @BaseDecPl),
			PTDCostIssd10 = Round(PTDCostIssd10 + @PTDCostIssd10, @BaseDecPl),
			PTDCostIssd11 = Round(PTDCostIssd11 + @PTDCostIssd11, @BaseDecPl),
			PTDCostIssd12 = Round(PTDCostIssd12 + @PTDCostIssd12, @BaseDecPl),
			YTDCostIssd = Round(YTDCostIssd + @Cost , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ItemHist_Issd] TO [MSDSL]
    AS [dbo];

