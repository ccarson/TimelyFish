 Create	Procedure SCM_10400_BOMDoc
	@BatNbr	VarChar(10)
As
	Select	*
		From	BOMDoc (NoLock)
		Where	BatNbr = @BatNbr


