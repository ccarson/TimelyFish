 Create	Procedure SCM_10400_ErrorReturn
	@ComputerName	VarChar(21)
As
	Select	BatNbr, ComputerName, MsgNbr, Parm00, Parm01, Parm02, Parm03, Parm04, Parm05, S4Future01, SQLErrorNbr
		From	IN10400_Return (NoLock)
		Where	ComputerName = @ComputerName



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_ErrorReturn] TO [MSDSL]
    AS [dbo];

