 Create	Procedure SCM_10400_Upd_Item2Hist_BegBal
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

	Declare	@BegQty		Float,
		@PrevFiscYr	Char(4)

	Select	@PrevFiscYr = Cast(Cast(@FiscYr As SmallInt) - 1 As Char(4))

	Select	@BegQty = Round(BegQty + YTDQtyAdjd - YTDQtyIssd + YTDQtyRcvd - YTDQtySls
		+ YTDQtyTrsfrIn - YTDQtyTrsfrOut, @DecPlQty)
		From	Item2Hist (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @PrevFiscYr
	Update	Item2Hist
		Set	BegQty = Round(BegQty + Round(Coalesce(@BegQty, 0) + @Qty, @DecPlQty), @DecPlQty)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_Item2Hist_BegBal] TO [MSDSL]
    AS [dbo];

