 Create	Procedure SCM_10400_Upd_Item2Hist_Rcvd
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

	Declare	@PTDQtyRcvd00 Float, @PTDQtyRcvd01 Float, @PTDQtyRcvd02 Float, @PTDQtyRcvd03 Float, @PTDQtyRcvd04 Float,
		@PTDQtyRcvd05 Float, @PTDQtyRcvd06 Float, @PTDQtyRcvd07 Float, @PTDQtyRcvd08 Float, @PTDQtyRcvd09 Float,
		@PTDQtyRcvd10 Float, @PTDQtyRcvd11 Float, @PTDQtyRcvd12 Float
		Select	@PTDQtyRcvd00 = 0, @PTDQtyRcvd01 = 0, @PTDQtyRcvd02 = 0, @PTDQtyRcvd03 = 0, @PTDQtyRcvd04 = 0,
		@PTDQtyRcvd05 = 0, @PTDQtyRcvd06 = 0, @PTDQtyRcvd07 = 0, @PTDQtyRcvd08 = 0, @PTDQtyRcvd09 = 0,
		@PTDQtyRcvd10 = 0, @PTDQtyRcvd11 = 0, @PTDQtyRcvd12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtyRcvd00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtyRcvd01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtyRcvd02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtyRcvd03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtyRcvd04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtyRcvd05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtyRcvd06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtyRcvd07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtyRcvd08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtyRcvd09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtyRcvd10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtyRcvd11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtyRcvd12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtyRcvd00 = Round(PTDQtyRcvd00 + @PTDQtyRcvd00, @DecPlQty),
			PTDQtyRcvd01 = Round(PTDQtyRcvd01 + @PTDQtyRcvd01, @DecPlQty),
			PTDQtyRcvd02 = Round(PTDQtyRcvd02 + @PTDQtyRcvd02, @DecPlQty),
			PTDQtyRcvd03 = Round(PTDQtyRcvd03 + @PTDQtyRcvd03, @DecPlQty),
			PTDQtyRcvd04 = Round(PTDQtyRcvd04 + @PTDQtyRcvd04, @DecPlQty),
			PTDQtyRcvd05 = Round(PTDQtyRcvd05 + @PTDQtyRcvd05, @DecPlQty),
			PTDQtyRcvd06 = Round(PTDQtyRcvd06 + @PTDQtyRcvd06, @DecPlQty),
			PTDQtyRcvd07 = Round(PTDQtyRcvd07 + @PTDQtyRcvd07, @DecPlQty),
			PTDQtyRcvd08 = Round(PTDQtyRcvd08 + @PTDQtyRcvd08, @DecPlQty),
			PTDQtyRcvd09 = Round(PTDQtyRcvd09 + @PTDQtyRcvd09, @DecPlQty),
			PTDQtyRcvd10 = Round(PTDQtyRcvd10 + @PTDQtyRcvd10, @DecPlQty),
			PTDQtyRcvd11 = Round(PTDQtyRcvd11 + @PTDQtyRcvd11, @DecPlQty),
			PTDQtyRcvd12 = Round(PTDQtyRcvd12 + @PTDQtyRcvd12, @DecPlQty),
			YTDQtyRcvd = Round(YTDQtyRcvd + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


