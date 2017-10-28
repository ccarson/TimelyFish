 Create	Procedure ADG_Insert_IN10530_Return
	@BatNbr		VarChar(10),
	@Batch_Created	Char(1),
	@ComputerName	VarChar(21),
	@ErrorFlag	Char(1),
	@CpnyID		VarChar(30), /* ErrorInvtID Field Used */
	@ErrorMessage	VarChar(4),
	@Process_Flag	Char(1)
As
	Insert Into IN10530_Return
		(BatNbr, Batch_Created, ComputerName, Crtd_DateTime, ErrorFlag,
			ErrorInvtID, ErrorMessage, Process_Flag)
		Values	(@BatNbr, @Batch_Created, @ComputerName, GetDate(), @ErrorFlag,
			@CpnyID, @ErrorMessage, @Process_Flag)



GO
GRANT CONTROL
    ON OBJECT::[dbo].[ADG_Insert_IN10530_Return] TO [MSDSL]
    AS [dbo];

