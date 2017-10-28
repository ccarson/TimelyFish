 Create	Procedure SCM_10400_Upd_ItemHist_BegBal
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@Period		SmallInt,
	@FiscYr		Char(4),
	@Cost		Float,
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@BegBal		Float,
		@PrevFiscYr	Char(4)

	Select	@PrevFiscYr = Cast(Cast(@FiscYr As SmallInt) - 1 As Char(4))

	Select	@BegBal = Round(BegBal - YTDCOGS + YTDCostAdjd - YTDCostIssd + YTDCostRcvd
		+ YTDCostTrsfrIn - YTDCostTrsfrOut, @BaseDecPl)
		From	ItemHist (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @PrevFiscYr
	Update	ItemHist
		Set	BegBal = Round(BegBal + Round(Coalesce(@BegBal, 0) + @Cost, @BaseDecPl), @BaseDecPl)
		Where	InvtID = @InvtID
			And SiteID = @SiteID
			And FiscYr = @FiscYr


