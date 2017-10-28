 

Create	View vp_AB_Balances
As
	
	Select	InvtID, SiteID, FiscYr = Left(INTran.PerPost, 4),
		Beg_Cost = Sum(Case	When	INTran.TranType = 'AB'
						Then	Round(INTran.ExtCost * INTran.InvtMult, DecPl.BaseDecPl)
					Else	0
				End),
		BMI_BegCost = Sum(Case	When	INTran.TranType = 'AB'
						Then	Round(INTran.BMIExtCost * INTran.InvtMult, DecPl.BMIDecPl)
					Else	0
				End),
		Beg_Qty = Sum(Case	When	INTran.TranType = 'AB'
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, DecPl.DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, DecPl.DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, DecPl.DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, DecPl.DecPlQty)
								Else	0
							End
					Else	0
				End)
		From	INTran (NoLock), vp_DecPl DecPl (NoLock)
		Where	INTran.Rlsed = 1
			And INTran.S4Future05 = 0
			And INTran.InSuffQty = 0
			And Round(INTran.Qty * INTran.InvtMult, DecPl.DecPlQty) <> 0
		Group By InvtID, SiteID, Left(INTran.PerPost, 4)

 
