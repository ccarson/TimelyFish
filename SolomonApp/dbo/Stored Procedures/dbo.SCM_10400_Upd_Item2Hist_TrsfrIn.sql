 Create	Procedure SCM_10400_Upd_Item2Hist_TrsfrIn
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

	Declare	@PTDQtyTrsfrIn00 Float, @PTDQtyTrsfrIn01 Float, @PTDQtyTrsfrIn02 Float, @PTDQtyTrsfrIn03 Float, @PTDQtyTrsfrIn04 Float,
		@PTDQtyTrsfrIn05 Float, @PTDQtyTrsfrIn06 Float, @PTDQtyTrsfrIn07 Float, @PTDQtyTrsfrIn08 Float, @PTDQtyTrsfrIn09 Float,
		@PTDQtyTrsfrIn10 Float, @PTDQtyTrsfrIn11 Float, @PTDQtyTrsfrIn12 Float
		Select	@PTDQtyTrsfrIn00 = 0, @PTDQtyTrsfrIn01 = 0, @PTDQtyTrsfrIn02 = 0, @PTDQtyTrsfrIn03 = 0, @PTDQtyTrsfrIn04 = 0,
		@PTDQtyTrsfrIn05 = 0, @PTDQtyTrsfrIn06 = 0, @PTDQtyTrsfrIn07 = 0, @PTDQtyTrsfrIn08 = 0, @PTDQtyTrsfrIn09 = 0,
		@PTDQtyTrsfrIn10 = 0, @PTDQtyTrsfrIn11 = 0, @PTDQtyTrsfrIn12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtyTrsfrIn00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtyTrsfrIn01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtyTrsfrIn02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtyTrsfrIn03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtyTrsfrIn04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtyTrsfrIn05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtyTrsfrIn06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtyTrsfrIn07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtyTrsfrIn08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtyTrsfrIn09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtyTrsfrIn10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtyTrsfrIn11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtyTrsfrIn12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtyTrsfrIn00 = Round(PTDQtyTrsfrIn00 + @PTDQtyTrsfrIn00, @DecPlQty),
			PTDQtyTrsfrIn01 = Round(PTDQtyTrsfrIn01 + @PTDQtyTrsfrIn01, @DecPlQty),
			PTDQtyTrsfrIn02 = Round(PTDQtyTrsfrIn02 + @PTDQtyTrsfrIn02, @DecPlQty),
			PTDQtyTrsfrIn03 = Round(PTDQtyTrsfrIn03 + @PTDQtyTrsfrIn03, @DecPlQty),
			PTDQtyTrsfrIn04 = Round(PTDQtyTrsfrIn04 + @PTDQtyTrsfrIn04, @DecPlQty),
			PTDQtyTrsfrIn05 = Round(PTDQtyTrsfrIn05 + @PTDQtyTrsfrIn05, @DecPlQty),
			PTDQtyTrsfrIn06 = Round(PTDQtyTrsfrIn06 + @PTDQtyTrsfrIn06, @DecPlQty),
			PTDQtyTrsfrIn07 = Round(PTDQtyTrsfrIn07 + @PTDQtyTrsfrIn07, @DecPlQty),
			PTDQtyTrsfrIn08 = Round(PTDQtyTrsfrIn08 + @PTDQtyTrsfrIn08, @DecPlQty),
			PTDQtyTrsfrIn09 = Round(PTDQtyTrsfrIn09 + @PTDQtyTrsfrIn09, @DecPlQty),
			PTDQtyTrsfrIn10 = Round(PTDQtyTrsfrIn10 + @PTDQtyTrsfrIn10, @DecPlQty),
			PTDQtyTrsfrIn11 = Round(PTDQtyTrsfrIn11 + @PTDQtyTrsfrIn11, @DecPlQty),
			PTDQtyTrsfrIn12 = Round(PTDQtyTrsfrIn12 + @PTDQtyTrsfrIn12, @DecPlQty),
			YTDQtyTrsfrIn = Round(YTDQtyTrsfrIn + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


