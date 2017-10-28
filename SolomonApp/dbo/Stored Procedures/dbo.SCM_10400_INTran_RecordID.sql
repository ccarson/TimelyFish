 Create Procedure SCM_10400_INTran_RecordID
	@BatNbr VarChar(10),
	@RefNbr VarChar(15),
	@LineRef VarChar(5),
	@TranType VarChar(2)
As
	Declare	@RecordID	Integer
	Set	@RecordID = 0
	Select	@RecordID = RecordID
		From	INTran (NoLock)
		Where	BatNbr = @BatNbr
			And RefNbr = @RefNbr
			And LineRef = @LineRef
			And TranType = @TranType
	Select	RecordID = @RecordID


