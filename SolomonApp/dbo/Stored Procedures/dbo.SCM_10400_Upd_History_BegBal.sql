 Create	Procedure SCM_10400_Upd_History_BegBal
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@FiscYr		Char(4),
		@PrevFiscYr	Char(4),
		@RowCntr	Int

	Select	@RowCntr = 1, @PrevFiscYr = '', @FiscYr = ''

	Update	ItemHist
		Set	ItemHist.BegBal = ABTran.Beg_Cost
		From	ItemHist Inner Join vp_AB_Balances ABTran (NoLock)
			On ItemHist.InvtID = ABTran.InvtID
			And ItemHist.SiteID = ABTran.SiteID
			And ItemHist.FiscYr = ABTran.FiscYr
		Where	Round(ABTran.Beg_Cost, @BaseDecPl) <> 0

	Update	Item2Hist
		Set	Item2Hist.BegQty = Beg_Qty
		From	Item2Hist Inner Join vp_AB_Balances ABTran (NoLock)
			On Item2Hist.InvtID = ABTran.InvtID
			And Item2Hist.SiteID = ABTran.SiteID
			And Item2Hist.FiscYr = ABTran.FiscYr
		Where	Round(ABTran.Beg_Qty, @DecPlQty) <> 0

	Update	ItemBMIHist
		Set	ItemBMIHist.BMIBegBal = BMI_BegCost
		From	ItemBMIHist Inner Join vp_AB_Balances ABTran (NoLock)
			On ItemBMIHist.InvtID = ABTran.InvtID
			And ItemBMIHist.SiteID = ABTran.SiteID
			And ItemBMIHist.FiscYr = ABTran.FiscYr
		Where	Round(ABTran.BMI_BegCost, @BMIDecPl) <> 0

	Declare	@MinFiscYr	SmallInt,
		@MaxFiscYr	SmallInt

	Select	@MinFiscYr = 0,
		@MaxFiscYr = 0

	Select	@MinFiscYr = Min(Cast(FiscYr As SmallInt)),
		@MaxFiscYr = Max(Cast(FiscYr As SmallInt))
		From	ItemHist (NoLock)

	While	(@MaxFiscYr > @MinFiscYr)
	Begin
			Set	@PrevFiscYr = Cast(@MinFiscYr As Char(4))
		Set	@FiscYr = Cast(@MinFiscYr + 1 As Char(4))

		Update	ItemHist
			Set	ItemHist.BegBal = Round(PrevYear.BegBal - PrevYear.YTDCOGS
				+ PrevYear.YTDCostAdjd - PrevYear.YTDCostIssd + PrevYear.YTDCostRcvd
				+ PrevYear.YTDCostTrsfrIn - PrevYear.YTDCostTrsfrOut, @BaseDecPl),
				LUpd_Prog = @LUpd_Prog,
				LUpd_User = @LUpd_User,
				LUpd_DateTime = GetDate()
			From	ItemHist Inner Join ItemHist PrevYear
				On ItemHist.InvtID = PrevYear.InvtID
				And ItemHist.SiteID = PrevYear.SiteID
			Where	ItemHist.FiscYr = @FiscYr
				And PrevYear.FiscYr = @PrevFiscYr
			Update	Item2Hist
			Set	Item2Hist.BegQty = Round(PrevYear.BegQty + PrevYear.YTDQtyAdjd
				- PrevYear.YTDQtyIssd + PrevYear.YTDQtyRcvd - PrevYear.YTDQtySls
				+ PrevYear.YTDQtyTrsfrIn - PrevYear.YTDQtyTrsfrOut, @DecPlQty),
				LUpd_Prog = @LUpd_Prog,
				LUpd_User = @LUpd_User,
				LUpd_DateTime = GetDate()
			From	Item2Hist Inner Join Item2Hist PrevYear
				On Item2Hist.InvtID = PrevYear.InvtID
				And Item2Hist.SiteID = PrevYear.SiteID
			Where	Item2Hist.FiscYr = @FiscYr
				And PrevYear.FiscYr = @PrevFiscYr
			Update	ItemBMIHist
			Set	ItemBMIHist.BMIBegBal = Round(PrevYear.BMIBegBal - PrevYear.BMIYTDCOGS + PrevYear.BMIYTDCostAdjd
				- PrevYear.BMIYTDCostIssd + PrevYear.BMIYTDCostRcvd, @BMIDecPl),
				LUpd_Prog = @LUpd_Prog,
				LUpd_User = @LUpd_User,
				LUpd_DateTime = GetDate()
			From	ItemBMIHist Inner Join ItemBMIHist PrevYear
				On ItemBMIHist.InvtID = PrevYear.InvtID
				And ItemBMIHist.SiteID = PrevYear.SiteID
			Where	ItemBMIHist.FiscYr = @FiscYr
				And PrevYear.FiscYr = @PrevFiscYr

		Select	@MinFiscYr = @MinFiscYr + 1

	End



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Upd_History_BegBal] TO [MSDSL]
    AS [dbo];

