 Create Procedure INTRAN_RecordID
	@RecordID	Integer
As
	Select	*
		From	INTran (NoLock)
		Where	RecordID = @RecordID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[INTRAN_RecordID] TO [MSDSL]
    AS [dbo];

