 Create	Procedure SCM_10990_HistoryData
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@LockYear	Char(4),
	@BaseDecPl	SmallInt,
	@BMIDecPl	SmallInt,
	@DecPlPrcCst	SmallInt,
	@DecPlQty	SmallInt
As
	Set	NoCount On

	Declare	@CurrFiscYr	Char(4)

	Select	@CurrFiscYr = SUBSTRING(PERNBR, 1, 4) FROM INSETUP (NOLOCK)

	Select	INTran.InvtID, INTran.SiteID, FiscYr = Left(INTran.PerPost, 4), Period = Right(INTran.PerPost, 2),
		MinFiscYr = Case 	When	Left(INTran.PerPost, 4) < @CurrFiscYr
						Then Min(Left(INTran.PerPost, 4))
					Else	@CurrFiscYr
			    End,
		MaxFiscYr = Case	When	Left(INTran.PerPost, 4) > @CurrFiscYr
						Then Max(Left(INTran.PerPost, 4))
					Else	@CurrFiscYr
			    End,
		COGS_Cost = Sum(Case	When	INTran.TranType = 'CG' And (INTran.S4Future09 = 0 Or (INTran.S4Future09 = 1 and Inventory.StkItem = 1)) And INTran.TranDesc <> 'Overhead Entry'
						Then	Round(INTran.TranAmt * INTran.InvtMult * -1, @BaseDecPl)
					When	INTran.TranType = 'CM' and INTran.S4Future09 <> 0
						Then	Round(INTran.ExtCost * INTran.InvtMult * -1, @BaseDecPl)
					Else	0
				End),
		BMICOGS_Cost = Sum(Case	When	INTran.TranType = 'CG' And INTran.S4Future09 = 0 And INTran.TranDesc <> 'Overhead Entry'
						Then	Round(INTran.BMITranAmt * INTran.InvtMult * -1, @BMIDecPl)
					When	INTran.Trantype = 'CM' and INTran.S4Future09 <> 0
						Then	Round(INTran.BMIExtCost * INTran.InvtMult * -1, @BMIDecPl)
					Else	0
				End),
		Adjd_Cost = Sum(Case	When	INTran.TranType In ('AC', 'AJ', 'PI')
						Then	Round(INTran.TranAmt * INTran.InvtMult, @BaseDecPl)
					When	INTran.TranType = 'CM' and INTran.S4Future09 <> 0
						Then	Round(INTran.ExtCost * INTran.InvtMult * -1, @BaseDecPl)
					Else	0
				End),
		BMIAdjd_Cost = Sum(Case	When	INTran.TranType In ('AC', 'AJ', 'PI')
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, @BMIDecPl)
					When	INTran.TranType = 'CM' and INTran.S4Future09 <> 0
						Then	Round(INTran.BMIExtCost * INTran.InvtMult * -1, @BMIDecPl)
					Else	0
				End),
		DropShipSals_COGS = Sum(Case	When	INTran.TranType = 'IN' and INTran.S4Future09  = 1 and Inventory.StkItem = 1
						Then	Round(INTran.ExtCost * INTran.InvtMult * -1, @BaseDecPl)
					Else	0
				End),
		Issd_Cost = Sum(Case	When	INTran.TranType = 'II'
						Or (INTran.TranType = 'AS' And RTrim(INTran.KitID) <> '')
						Then	Round(INTran.TranAmt * INTran.InvtMult * -1, @BaseDecPl)
					When	INTran.TranType = 'RI'
						Then	Round(INTran.ExtCost * INTran.InvtMult * -1, @BaseDecPl)
					Else	0
				End),
		BMIIssd_Cost = Sum(Case	When	INTran.TranType In ('II', 'RI')
						Or (INTran.TranType = 'AS' And RTrim(INTran.KitID) <> '')
						Then	Round(INTran.BMITranAmt * INTran.InvtMult * -1, @BMIDecPl)
					Else	0
				End),
		Rcvd_Cost = Sum(Case	When	INTran.TranType In ('AS', 'RC') And RTrim(INTran.KitID) = ''
						Then	Round(INTran.TranAmt * INTran.InvtMult, @BaseDecPl)
					Else	0
				End),
		BMIRcvd_Cost = Sum(Case	When	INTran.TranType In ('AS', 'RC') And RTrim(INTran.KitID) = ''
						Then	Round(INTran.BMITranAmt * INTran.InvtMult, @BMIDecPl)
					Else	0
				End),
		Sals_Price = Sum(Case	When	INTran.TranType In ('CM', 'DM', 'IN')
						Then	Round(INTran.TranAmt * INTran.InvtMult * -1, @BaseDecPl)
					Else	0
				End),
		TrIn_Cost = Sum(Case	When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) = ''
						Then	Round(INTran.TranAmt * INTran.InvtMult, @BaseDecPl)
					Else	0
				End),
		TrOut_Cost = Sum(Case	When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) <> ''
						Then	Round(INTran.TranAmt * INTran.InvtMult * -1, @BaseDecPl)
					Else	0
				End),
		Adjd_Qty = Sum(	Case	When	INTran.TranType In ('AC', 'AJ', 'PI')
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End
					When	INTran.TranType = 'CM' And INTran.S4Future09 <> 0 /*  Scrap  */
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult * -1, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult * -1) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult * -1) * INTran.CnvFact, @DecPlQty)
								Else	0
							End
					Else	0
				End),
		DropShipSals_Qty = Sum(Case	When	INTran.TranType ='IN' and INTran.S4Future09 = 1 and Inventory.StkItem = 1
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End * -1
					Else	0
				End),
		Issd_Qty = Sum(	Case	When	INTran.TranType In ('II', 'RI')
						Or (INTran.TranType = 'AS' And RTrim(INTran.KitID) <> '')
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End * -1
					Else	0
				End),
		Rcvd_Qty = Sum(	Case	When	INTran.TranType In ('AS', 'RC') And RTrim(INTran.KitID) = ''
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End
					Else	0
				End),
		Sals_Qty = Sum(Case	When	INTran.TranType In ('CM', 'IN')	or (INTran.TranType = 'DM' and INTran.Jrnltype <> 'OM')
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End * -1
					Else	0
				End),
		TrIn_Qty = Sum(	Case	When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) = ''
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End
					Else	0
				End),
		TrOut_Qty = Sum(Case	When	INTran.TranType = 'TR'
						And RTrim(INTran.ToSiteID) <> ''
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End * -1
					Else	0
				End)
		From	INTran (NoLock) LEFT JOIN
			Inventory (NoLock) ON INTran.InvtID = Inventory.InvtID

		Where	INTran.Rlsed = 1
			And INTran.S4Future05 = 0
			And FiscYr > @LockYear
			And INTran.InvtID =	Case 	When 	RTrim(@InvtID) <> ''
							Then	@InvtID
						Else	INTran.InvtID
					End
			And SiteID =	Case 	When 	RTrim(@SiteID) <> ''
							Then	@SiteID
						Else	SiteID
					End
		Group By INTran.InvtID, INTran.SiteID, INTran.PerPost
		Order By INTran.InvtID, INTran.SiteID, INTran.PerPost


