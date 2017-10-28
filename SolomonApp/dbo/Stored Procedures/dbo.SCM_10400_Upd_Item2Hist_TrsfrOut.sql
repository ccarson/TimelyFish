 Create	Procedure SCM_10400_Upd_Item2Hist_TrsfrOut
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

	Declare	@PTDQtyTrsfrOut00 Float, @PTDQtyTrsfrOut01 Float, @PTDQtyTrsfrOut02 Float, @PTDQtyTrsfrOut03 Float, @PTDQtyTrsfrOut04 Float,
		@PTDQtyTrsfrOut05 Float, @PTDQtyTrsfrOut06 Float, @PTDQtyTrsfrOut07 Float, @PTDQtyTrsfrOut08 Float, @PTDQtyTrsfrOut09 Float,
		@PTDQtyTrsfrOut10 Float, @PTDQtyTrsfrOut11 Float, @PTDQtyTrsfrOut12 Float
		Select	@PTDQtyTrsfrOut00 = 0, @PTDQtyTrsfrOut01 = 0, @PTDQtyTrsfrOut02 = 0, @PTDQtyTrsfrOut03 = 0, @PTDQtyTrsfrOut04 = 0,
		@PTDQtyTrsfrOut05 = 0, @PTDQtyTrsfrOut06 = 0, @PTDQtyTrsfrOut07 = 0, @PTDQtyTrsfrOut08 = 0, @PTDQtyTrsfrOut09 = 0,
		@PTDQtyTrsfrOut10 = 0, @PTDQtyTrsfrOut11 = 0, @PTDQtyTrsfrOut12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtyTrsfrOut00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtyTrsfrOut01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtyTrsfrOut02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtyTrsfrOut03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtyTrsfrOut04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtyTrsfrOut05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtyTrsfrOut06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtyTrsfrOut07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtyTrsfrOut08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtyTrsfrOut09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtyTrsfrOut10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtyTrsfrOut11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtyTrsfrOut12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtyTrsfrOut00 = Round(PTDQtyTrsfrOut00 + @PTDQtyTrsfrOut00, @DecPlQty),
			PTDQtyTrsfrOut01 = Round(PTDQtyTrsfrOut01 + @PTDQtyTrsfrOut01, @DecPlQty),
			PTDQtyTrsfrOut02 = Round(PTDQtyTrsfrOut02 + @PTDQtyTrsfrOut02, @DecPlQty),
			PTDQtyTrsfrOut03 = Round(PTDQtyTrsfrOut03 + @PTDQtyTrsfrOut03, @DecPlQty),
			PTDQtyTrsfrOut04 = Round(PTDQtyTrsfrOut04 + @PTDQtyTrsfrOut04, @DecPlQty),
			PTDQtyTrsfrOut05 = Round(PTDQtyTrsfrOut05 + @PTDQtyTrsfrOut05, @DecPlQty),
			PTDQtyTrsfrOut06 = Round(PTDQtyTrsfrOut06 + @PTDQtyTrsfrOut06, @DecPlQty),
			PTDQtyTrsfrOut07 = Round(PTDQtyTrsfrOut07 + @PTDQtyTrsfrOut07, @DecPlQty),
			PTDQtyTrsfrOut08 = Round(PTDQtyTrsfrOut08 + @PTDQtyTrsfrOut08, @DecPlQty),
			PTDQtyTrsfrOut09 = Round(PTDQtyTrsfrOut09 + @PTDQtyTrsfrOut09, @DecPlQty),
			PTDQtyTrsfrOut10 = Round(PTDQtyTrsfrOut10 + @PTDQtyTrsfrOut10, @DecPlQty),
			PTDQtyTrsfrOut11 = Round(PTDQtyTrsfrOut11 + @PTDQtyTrsfrOut11, @DecPlQty),
			PTDQtyTrsfrOut12 = Round(PTDQtyTrsfrOut12 + @PTDQtyTrsfrOut12, @DecPlQty),
			YTDQtyTrsfrOut = Round(YTDQtyTrsfrOut + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


