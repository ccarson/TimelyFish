 Create	Procedure SCM_10400_BatchTranType
	@BatNbr		VarChar(10),
	@CpnyID		VarChar(10),
	@LineRef	VarChar( 5)

As

	Select * From  	INTran (NoLock)
		Where 	BatNbr = @BatNbr
		  	And CpnyID = @CpnyID
			And LineRef = @LineRef
			And TranType <> 'CT'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_BatchTranType] TO [MSDSL]
    AS [dbo];

