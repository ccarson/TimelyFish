 Create	Procedure SCM_10400_Upd_ItemHist_Sls
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@Period		SmallInt,
	@FiscYr		Char(4),
	@Price		Float,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@PTDSls00 Float, @PTDSls01 Float, @PTDSls02 Float, @PTDSls03 Float, @PTDSls04 Float,
		@PTDSls05 Float, @PTDSls06 Float, @PTDSls07 Float, @PTDSls08 Float, @PTDSls09 Float,
		@PTDSls10 Float, @PTDSls11 Float, @PTDSls12 Float
		Select	@PTDSls00 = 0, @PTDSls01 = 0, @PTDSls02 = 0, @PTDSls03 = 0, @PTDSls04 = 0,
		@PTDSls05 = 0, @PTDSls06 = 0, @PTDSls07 = 0, @PTDSls08 = 0, @PTDSls09 = 0,
		@PTDSls10 = 0, @PTDSls11 = 0, @PTDSls12 = 0

	If	@Period = 1
	Begin
		Set	@PTDSls00 = @Price
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDSls01 = @Price
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDSls02 = @Price
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDSls03 = @Price
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDSls04 = @Price
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDSls05 = @Price
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDSls06 = @Price
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDSls07 = @Price
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDSls08 = @Price
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDSls09 = @Price
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDSls10 = @Price
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDSls11 = @Price
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDSls12 = @Price
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDSls00 = Round(PTDSls00 + @PTDSls00, @BaseDecPl),
			PTDSls01 = Round(PTDSls01 + @PTDSls01, @BaseDecPl),
			PTDSls02 = Round(PTDSls02 + @PTDSls02, @BaseDecPl),
			PTDSls03 = Round(PTDSls03 + @PTDSls03, @BaseDecPl),
			PTDSls04 = Round(PTDSls04 + @PTDSls04, @BaseDecPl),
			PTDSls05 = Round(PTDSls05 + @PTDSls05, @BaseDecPl),
			PTDSls06 = Round(PTDSls06 + @PTDSls06, @BaseDecPl),
			PTDSls07 = Round(PTDSls07 + @PTDSls07, @BaseDecPl),
			PTDSls08 = Round(PTDSls08 + @PTDSls08, @BaseDecPl),
			PTDSls09 = Round(PTDSls09 + @PTDSls09, @BaseDecPl),
			PTDSls10 = Round(PTDSls10 + @PTDSls10, @BaseDecPl),
			PTDSls11 = Round(PTDSls11 + @PTDSls11, @BaseDecPl),
			PTDSls12 = Round(PTDSls12 + @PTDSls12, @BaseDecPl),
			YTDSls = Round(YTDSls + @Price , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


