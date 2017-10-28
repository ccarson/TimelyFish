 Create	Procedure SCM_10400_AB_Balances
	@InvtID		VarChar(30),
	@SiteID		VarChar(10),
	@FiscYr		VarChar(4),
	@BaseDecPl	SmallInt,
	@BMIDecPl 	SmallInt,
	@DecPlPrcCst 	SmallInt,
	@DecPlQty 	SmallInt,
	@Beg_Cost	Float OutPut,
	@BMI_BegCost	Float OutPut,
	@Beg_Qty	Float OutPut
As
	Set	NoCount On

	Select	@Beg_Cost = 0, @BMI_BegCost = 0, @Beg_Qty = 0

	Select	@Beg_Cost = Sum(Case	When	INTran.TranType = 'AB'
						Then	Round(INTran.ExtCost * INTran.InvtMult, @BaseDecPl)
					Else	0
				End),
		@BMI_BegCost = Sum(Case	When	INTran.TranType = 'AB'
						Then	Round(INTran.BMIExtCost * INTran.InvtMult, @BMIDecPl)
					Else	0
				End),
		@Beg_Qty = Sum(Case	When	INTran.TranType = 'AB'
						Then	Case	When	INTran.CnvFact In (0, 1)
									Then	Round(INTran.Qty * INTran.InvtMult, @DecPlQty)
								When	INTran.UnitMultDiv = 'D'
									Then	Round((INTran.Qty * INTran.InvtMult) / INTran.CnvFact, @DecPlQty)
								When	Round(INTran.Qty * INTran.InvtMult, @DecPlQty) <> 0
									Then	Round((INTran.Qty * INTran.InvtMult) * INTran.CnvFact, @DecPlQty)
								Else	0
							End
					Else	0
				End)
		From	INTran (NoLock)
		Where	INTran.Rlsed = 1
			And INTran.S4Future05 = 0
			And InvtID = @InvtID
			And SiteID = @SiteID
			And Left(INTran.PerPost, 4) = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_AB_Balances] TO [MSDSL]
    AS [dbo];

