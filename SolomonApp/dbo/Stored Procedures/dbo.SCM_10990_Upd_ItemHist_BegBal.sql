 Create	Procedure SCM_10990_Upd_ItemHist_BegBal
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@FiscYr		Char(4),
	@LUpd_Prog	VarChar(8),
	@LUpd_User	VarChar(10),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt
As
	Set	NoCount On

	Declare	@PrevFiscYr	Char(4),
		@RowCntr	Int

	If Not Exists(Select * From Inventory Where InvtId = @InvtId And StkItem = 1 And ValMthd <> 'U') Return

	Select	@RowCntr = 1, @PrevFiscYr = ''

	Declare	@MinFiscYr	SmallInt,
		@MaxFiscYr	SmallInt

	Select	@MinFiscYr = 0,
		@MaxFiscYr = 0

	Select	@MinFiscYr = Cast(Min(FiscYr) As SmallInt),
		@MaxFiscYr = Cast(Max(FiscYr) As SmallInt)
		From	ItemHist (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID

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
				And ItemHist.InvtID = @InvtID
				And ItemHist.SiteID = @SiteID
			Select	@MinFiscYr = @MinFiscYr + 1

	End


