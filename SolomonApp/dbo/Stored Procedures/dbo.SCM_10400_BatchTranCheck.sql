 Create	Procedure SCM_10400_BatchTranCheck
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10)
As

	Declare	@RecordCount	Integer
	Set	@RecordCount = 0

	Select	@RecordCount = Count(*)
		From	INTran (NoLock)
		Where	BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And TranType Not In ('CT', 'CG')
			And Rlsed = 0
		Group By BatNbr, CpnyID
	Select	RecordCount = @RecordCount



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_BatchTranCheck] TO [MSDSL]
    AS [dbo];

