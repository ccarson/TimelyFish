 Create	Procedure SCM_10400_Upd_Item2Hist_DropShipSls
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

	Declare	@PTDQtyDShpSls00 Float, @PTDQtyDShpSls01 Float, @PTDQtyDShpSls02 Float, @PTDQtyDShpSls03 Float, @PTDQtyDShpSls04 Float,
		@PTDQtyDShpSls05 Float, @PTDQtyDShpSls06 Float, @PTDQtyDShpSls07 Float, @PTDQtyDShpSls08 Float, @PTDQtyDShpSls09 Float,
		@PTDQtyDShpSls10 Float, @PTDQtyDShpSls11 Float, @PTDQtyDShpSls12 Float
		Select	@PTDQtyDShpSls00 = 0, @PTDQtyDShpSls01 = 0, @PTDQtyDShpSls02 = 0, @PTDQtyDShpSls03 = 0, @PTDQtyDShpSls04 = 0,
		@PTDQtyDShpSls05 = 0, @PTDQtyDShpSls06 = 0, @PTDQtyDShpSls07 = 0, @PTDQtyDShpSls08 = 0, @PTDQtyDShpSls09 = 0,
		@PTDQtyDShpSls10 = 0, @PTDQtyDShpSls11 = 0, @PTDQtyDShpSls12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtyDShpSls00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtyDShpSls01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtyDShpSls02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtyDShpSls03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtyDShpSls04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtyDShpSls05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtyDShpSls06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtyDShpSls07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtyDShpSls08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtyDShpSls09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtyDShpSls10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtyDShpSls11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtyDShpSls12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtyDShpSls00 = Round(PTDQtyDShpSls00 + @PTDQtyDShpSls00, @DecPlQty),
			PTDQtyDShpSls01 = Round(PTDQtyDShpSls01 + @PTDQtyDShpSls01, @DecPlQty),
			PTDQtyDShpSls02 = Round(PTDQtyDShpSls02 + @PTDQtyDShpSls02, @DecPlQty),
			PTDQtyDShpSls03 = Round(PTDQtyDShpSls03 + @PTDQtyDShpSls03, @DecPlQty),
			PTDQtyDShpSls04 = Round(PTDQtyDShpSls04 + @PTDQtyDShpSls04, @DecPlQty),
			PTDQtyDShpSls05 = Round(PTDQtyDShpSls05 + @PTDQtyDShpSls05, @DecPlQty),
			PTDQtyDShpSls06 = Round(PTDQtyDShpSls06 + @PTDQtyDShpSls06, @DecPlQty),
			PTDQtyDShpSls07 = Round(PTDQtyDShpSls07 + @PTDQtyDShpSls07, @DecPlQty),
			PTDQtyDShpSls08 = Round(PTDQtyDShpSls08 + @PTDQtyDShpSls08, @DecPlQty),
			PTDQtyDShpSls09 = Round(PTDQtyDShpSls09 + @PTDQtyDShpSls09, @DecPlQty),
			PTDQtyDShpSls10 = Round(PTDQtyDShpSls10 + @PTDQtyDShpSls10, @DecPlQty),
			PTDQtyDShpSls11 = Round(PTDQtyDShpSls11 + @PTDQtyDShpSls11, @DecPlQty),
			PTDQtyDShpSls12 = Round(PTDQtyDShpSls12 + @PTDQtyDShpSls12, @DecPlQty),
			YTDQtyDShpSls = Round(YTDQtyDShpSls + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_Item2Hist_DropShipSls] TO [MSDSL]
    AS [dbo];

