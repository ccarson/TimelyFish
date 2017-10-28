 Create	Procedure SCM_10400_Upd_Item2Hist_Adjd
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

	Declare	@PTDQtyAdjd00 Float, @PTDQtyAdjd01 Float, @PTDQtyAdjd02 Float, @PTDQtyAdjd03 Float, @PTDQtyAdjd04 Float,
		@PTDQtyAdjd05 Float, @PTDQtyAdjd06 Float, @PTDQtyAdjd07 Float, @PTDQtyAdjd08 Float, @PTDQtyAdjd09 Float,
		@PTDQtyAdjd10 Float, @PTDQtyAdjd11 Float, @PTDQtyAdjd12 Float
		Select	@PTDQtyAdjd00 = 0, @PTDQtyAdjd01 = 0, @PTDQtyAdjd02 = 0, @PTDQtyAdjd03 = 0, @PTDQtyAdjd04 = 0,
		@PTDQtyAdjd05 = 0, @PTDQtyAdjd06 = 0, @PTDQtyAdjd07 = 0, @PTDQtyAdjd08 = 0, @PTDQtyAdjd09 = 0,
		@PTDQtyAdjd10 = 0, @PTDQtyAdjd11 = 0, @PTDQtyAdjd12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtyAdjd00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtyAdjd01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtyAdjd02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtyAdjd03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtyAdjd04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtyAdjd05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtyAdjd06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtyAdjd07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtyAdjd08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtyAdjd09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtyAdjd10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtyAdjd11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtyAdjd12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtyAdjd00 = Round(PTDQtyAdjd00 + @PTDQtyAdjd00, @DecPlQty),
			PTDQtyAdjd01 = Round(PTDQtyAdjd01 + @PTDQtyAdjd01, @DecPlQty),
			PTDQtyAdjd02 = Round(PTDQtyAdjd02 + @PTDQtyAdjd02, @DecPlQty),
			PTDQtyAdjd03 = Round(PTDQtyAdjd03 + @PTDQtyAdjd03, @DecPlQty),
			PTDQtyAdjd04 = Round(PTDQtyAdjd04 + @PTDQtyAdjd04, @DecPlQty),
			PTDQtyAdjd05 = Round(PTDQtyAdjd05 + @PTDQtyAdjd05, @DecPlQty),
			PTDQtyAdjd06 = Round(PTDQtyAdjd06 + @PTDQtyAdjd06, @DecPlQty),
			PTDQtyAdjd07 = Round(PTDQtyAdjd07 + @PTDQtyAdjd07, @DecPlQty),
			PTDQtyAdjd08 = Round(PTDQtyAdjd08 + @PTDQtyAdjd08, @DecPlQty),
			PTDQtyAdjd09 = Round(PTDQtyAdjd09 + @PTDQtyAdjd09, @DecPlQty),
			PTDQtyAdjd10 = Round(PTDQtyAdjd10 + @PTDQtyAdjd10, @DecPlQty),
			PTDQtyAdjd11 = Round(PTDQtyAdjd11 + @PTDQtyAdjd11, @DecPlQty),
			PTDQtyAdjd12 = Round(PTDQtyAdjd12 + @PTDQtyAdjd12, @DecPlQty),
			YTDQtyAdjd = Round(YTDQtyAdjd + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_Item2Hist_Adjd] TO [MSDSL]
    AS [dbo];

