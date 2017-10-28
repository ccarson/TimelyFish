 Create	Procedure SCM_10400_Upd_ItemHist_DropShipSls
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

	Declare	@PTDDShpSls00 Float, @PTDDShpSls01 Float, @PTDDShpSls02 Float, @PTDDShpSls03 Float, @PTDDShpSls04 Float,
		@PTDDShpSls05 Float, @PTDDShpSls06 Float, @PTDDShpSls07 Float, @PTDDShpSls08 Float, @PTDDShpSls09 Float,
		@PTDDShpSls10 Float, @PTDDShpSls11 Float, @PTDDShpSls12 Float
		Select	@PTDDShpSls00 = 0, @PTDDShpSls01 = 0, @PTDDShpSls02 = 0, @PTDDShpSls03 = 0, @PTDDShpSls04 = 0,
		@PTDDShpSls05 = 0, @PTDDShpSls06 = 0, @PTDDShpSls07 = 0, @PTDDShpSls08 = 0, @PTDDShpSls09 = 0,
		@PTDDShpSls10 = 0, @PTDDShpSls11 = 0, @PTDDShpSls12 = 0

	If	@Period = 1
	Begin
		Set	@PTDDShpSls00 = @Price
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDDShpSls01 = @Price
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDDShpSls02 = @Price
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDDShpSls03 = @Price
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDDShpSls04 = @Price
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDDShpSls05 = @Price
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDDShpSls06 = @Price
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDDShpSls07 = @Price
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDDShpSls08 = @Price
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDDShpSls09 = @Price
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDDShpSls10 = @Price
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDDShpSls11 = @Price
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDDShpSls12 = @Price
		Goto UpdStatement
	End

UpdStatement:

	Update	ItemHist
		Set	PTDDShpSls00 = Round(PTDDShpSls00 + @PTDDShpSls00, @BaseDecPl),
			PTDDShpSls01 = Round(PTDDShpSls01 + @PTDDShpSls01, @BaseDecPl),
			PTDDShpSls02 = Round(PTDDShpSls02 + @PTDDShpSls02, @BaseDecPl),
			PTDDShpSls03 = Round(PTDDShpSls03 + @PTDDShpSls03, @BaseDecPl),
			PTDDShpSls04 = Round(PTDDShpSls04 + @PTDDShpSls04, @BaseDecPl),
			PTDDShpSls05 = Round(PTDDShpSls05 + @PTDDShpSls05, @BaseDecPl),
			PTDDShpSls06 = Round(PTDDShpSls06 + @PTDDShpSls06, @BaseDecPl),
			PTDDShpSls07 = Round(PTDDShpSls07 + @PTDDShpSls07, @BaseDecPl),
			PTDDShpSls08 = Round(PTDDShpSls08 + @PTDDShpSls08, @BaseDecPl),
			PTDDShpSls09 = Round(PTDDShpSls09 + @PTDDShpSls09, @BaseDecPl),
			PTDDShpSls10 = Round(PTDDShpSls10 + @PTDDShpSls10, @BaseDecPl),
			PTDDShpSls11 = Round(PTDDShpSls11 + @PTDDShpSls11, @BaseDecPl),
			PTDDShpSls12 = Round(PTDDShpSls12 + @PTDDShpSls12, @BaseDecPl),
			YTDDShpSls = Round(YTDDShpSls + @Price , @BaseDecPl),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_ItemHist_DropShipSls] TO [MSDSL]
    AS [dbo];

