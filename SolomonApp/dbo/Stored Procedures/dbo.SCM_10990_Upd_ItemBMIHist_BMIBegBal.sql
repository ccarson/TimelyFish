 Create	Procedure SCM_10990_Upd_ItemBMIHist_BMIBegBal
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
		From	ItemBMIHist (NoLock)
		Where	InvtID = @InvtID
			And SiteID = @SiteID

	While	(@MaxFiscYr > @MinFiscYr)
	Begin
			Set	@PrevFiscYr = Cast(@MinFiscYr As Char(4))
		Set	@FiscYr = Cast(@MinFiscYr + 1 As Char(4))

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
				And ItemBMIHist.InvtID = @InvtID
				And ItemBMIHist.SiteID = @SiteID

		Select	@MinFiscYr = @MinFiscYr + 1

	End


