 Create	Procedure SCM_10400_BatchTrans
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@RecordID	Integer
As
	Set	NoCount On

	Declare	@ReturnID	Integer
	Set	@ReturnID = 0

	Select	Top 1
		@ReturnID = RecordID
		From	INTran (NoLock)
		Where	BatNbr = @BatNbr
			And CpnyID = @CpnyID
			And TranType Not In ('CT', 'CG')
			And Rlsed = 0
			And RecordID > @RecordID
		Order By BatNbr, CpnyID, RecordID
	Select	RecordID = @ReturnID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_BatchTrans] TO [MSDSL]
    AS [dbo];

