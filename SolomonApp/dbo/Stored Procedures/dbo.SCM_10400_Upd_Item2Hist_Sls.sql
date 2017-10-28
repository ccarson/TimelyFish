 Create	Procedure SCM_10400_Upd_Item2Hist_Sls
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@Period		SmallInt,
	@FiscYr		Char(4),
	@Qty		Float,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@PTDQtySls00 Float, @PTDQtySls01 Float, @PTDQtySls02 Float, @PTDQtySls03 Float, @PTDQtySls04 Float,
		@PTDQtySls05 Float, @PTDQtySls06 Float, @PTDQtySls07 Float, @PTDQtySls08 Float, @PTDQtySls09 Float,
		@PTDQtySls10 Float, @PTDQtySls11 Float, @PTDQtySls12 Float
		Select	@PTDQtySls00 = 0, @PTDQtySls01 = 0, @PTDQtySls02 = 0, @PTDQtySls03 = 0, @PTDQtySls04 = 0,
		@PTDQtySls05 = 0, @PTDQtySls06 = 0, @PTDQtySls07 = 0, @PTDQtySls08 = 0, @PTDQtySls09 = 0,
		@PTDQtySls10 = 0, @PTDQtySls11 = 0, @PTDQtySls12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtySls00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtySls01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtySls02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtySls03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtySls04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtySls05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtySls06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtySls07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtySls08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtySls09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtySls10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtySls11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtySls12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtySls00 = Round(PTDQtySls00 + @PTDQtySls00, @DecPlQty),
			PTDQtySls01 = Round(PTDQtySls01 + @PTDQtySls01, @DecPlQty),
			PTDQtySls02 = Round(PTDQtySls02 + @PTDQtySls02, @DecPlQty),
			PTDQtySls03 = Round(PTDQtySls03 + @PTDQtySls03, @DecPlQty),
			PTDQtySls04 = Round(PTDQtySls04 + @PTDQtySls04, @DecPlQty),
			PTDQtySls05 = Round(PTDQtySls05 + @PTDQtySls05, @DecPlQty),
			PTDQtySls06 = Round(PTDQtySls06 + @PTDQtySls06, @DecPlQty),
			PTDQtySls07 = Round(PTDQtySls07 + @PTDQtySls07, @DecPlQty),
			PTDQtySls08 = Round(PTDQtySls08 + @PTDQtySls08, @DecPlQty),
			PTDQtySls09 = Round(PTDQtySls09 + @PTDQtySls09, @DecPlQty),
			PTDQtySls10 = Round(PTDQtySls10 + @PTDQtySls10, @DecPlQty),
			PTDQtySls11 = Round(PTDQtySls11 + @PTDQtySls11, @DecPlQty),
			PTDQtySls12 = Round(PTDQtySls12 + @PTDQtySls12, @DecPlQty),
			YTDQtySls = Round(YTDQtySls + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


