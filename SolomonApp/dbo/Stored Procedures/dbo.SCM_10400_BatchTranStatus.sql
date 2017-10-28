 Create	Procedure SCM_10400_BatchTranStatus
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10)
As

	Declare	@RecordCount	Integer
	Set	@RecordCount = 0

	Select	@RecordCount = Count(*)
		From  INTran t (NoLock) Join Inventory i (NoLock) on t.Invtid = i.invtid and i.TranStatusCode = 'OH'
		Where t.BatNbr = @BatNbr
		  And t.CpnyID = @CpnyID

	Select	RecordCount = @RecordCount



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_BatchTranStatus] TO [MSDSL]
    AS [dbo];

