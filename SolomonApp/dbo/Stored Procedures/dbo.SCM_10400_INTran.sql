 Create	Procedure SCM_10400_INTran
	@BatNbr		VarChar(10),
	@LineRef	VarChar(5)
As
	Select	*
		From	INTran (NoLock)
		Where	BatNbr = @BatNbr
			And LineRef = @LineRef
			And TranType In ('CT', 'CG')
			And OvrhdFlag = 0


