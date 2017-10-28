 Create	Procedure SCM_10400_Upd_Item2Hist_Issd
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

	Declare	@PTDQtyIssd00 Float, @PTDQtyIssd01 Float, @PTDQtyIssd02 Float, @PTDQtyIssd03 Float, @PTDQtyIssd04 Float,
		@PTDQtyIssd05 Float, @PTDQtyIssd06 Float, @PTDQtyIssd07 Float, @PTDQtyIssd08 Float, @PTDQtyIssd09 Float,
		@PTDQtyIssd10 Float, @PTDQtyIssd11 Float, @PTDQtyIssd12 Float
		Select	@PTDQtyIssd00 = 0, @PTDQtyIssd01 = 0, @PTDQtyIssd02 = 0, @PTDQtyIssd03 = 0, @PTDQtyIssd04 = 0,
		@PTDQtyIssd05 = 0, @PTDQtyIssd06 = 0, @PTDQtyIssd07 = 0, @PTDQtyIssd08 = 0, @PTDQtyIssd09 = 0,
		@PTDQtyIssd10 = 0, @PTDQtyIssd11 = 0, @PTDQtyIssd12 = 0

	If	@Period = 1
	Begin
		Set	@PTDQtyIssd00 = @Qty
		Goto UpdStatement
	End
	If	@Period = 2
	Begin
		Set	@PTDQtyIssd01 = @Qty
		Goto UpdStatement
	End
	If	@Period = 3
	Begin
		Set	@PTDQtyIssd02 = @Qty
		Goto UpdStatement
	End
	If	@Period = 4
	Begin
		Set	@PTDQtyIssd03 = @Qty
		Goto UpdStatement
	End
	If	@Period = 5
	Begin
		Set	@PTDQtyIssd04 = @Qty
		Goto UpdStatement
	End
	If	@Period = 6
	Begin
		Set	@PTDQtyIssd05 = @Qty
		Goto UpdStatement
	End
	If	@Period = 7
	Begin
		Set	@PTDQtyIssd06 = @Qty
		Goto UpdStatement
	End
	If	@Period = 8
	Begin
		Set	@PTDQtyIssd07 = @Qty
		Goto UpdStatement
	End
	If	@Period = 9
	Begin
		Set	@PTDQtyIssd08 = @Qty
		Goto UpdStatement
	End
	If	@Period = 10
	Begin
		Set	@PTDQtyIssd09 = @Qty
		Goto UpdStatement
	End
	If	@Period = 11
	Begin
		Set	@PTDQtyIssd10 = @Qty
		Goto UpdStatement
	End
	If	@Period = 12
	Begin
		Set	@PTDQtyIssd11 = @Qty
		Goto UpdStatement
	End
	If	@Period = 13
	Begin
		Set	@PTDQtyIssd12 = @Qty
		Goto UpdStatement
	End

UpdStatement:

	Update	Item2Hist
		Set	PTDQtyIssd00 = Round(PTDQtyIssd00 + @PTDQtyIssd00, @DecPlQty),
			PTDQtyIssd01 = Round(PTDQtyIssd01 + @PTDQtyIssd01, @DecPlQty),
			PTDQtyIssd02 = Round(PTDQtyIssd02 + @PTDQtyIssd02, @DecPlQty),
			PTDQtyIssd03 = Round(PTDQtyIssd03 + @PTDQtyIssd03, @DecPlQty),
			PTDQtyIssd04 = Round(PTDQtyIssd04 + @PTDQtyIssd04, @DecPlQty),
			PTDQtyIssd05 = Round(PTDQtyIssd05 + @PTDQtyIssd05, @DecPlQty),
			PTDQtyIssd06 = Round(PTDQtyIssd06 + @PTDQtyIssd06, @DecPlQty),
			PTDQtyIssd07 = Round(PTDQtyIssd07 + @PTDQtyIssd07, @DecPlQty),
			PTDQtyIssd08 = Round(PTDQtyIssd08 + @PTDQtyIssd08, @DecPlQty),
			PTDQtyIssd09 = Round(PTDQtyIssd09 + @PTDQtyIssd09, @DecPlQty),
			PTDQtyIssd10 = Round(PTDQtyIssd10 + @PTDQtyIssd10, @DecPlQty),
			PTDQtyIssd11 = Round(PTDQtyIssd11 + @PTDQtyIssd11, @DecPlQty),
			PTDQtyIssd12 = Round(PTDQtyIssd12 + @PTDQtyIssd12, @DecPlQty),
			YTDQtyIssd = Round(YTDQtyIssd + @Qty , @DecPlQty),
			LUpd_DateTime = GetDate(),
			LUpd_Prog = @LUpd_Prog,
			LUpd_User = @LUpd_User
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_Item2Hist_Issd] TO [MSDSL]
    AS [dbo];

