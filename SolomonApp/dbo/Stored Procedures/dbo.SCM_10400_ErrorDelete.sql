 Create	Procedure SCM_10400_ErrorDelete
	@BatNbr		VarChar(10),
	@ComputerName	VarChar(21)
As
	Delete	From IN10400_Return
		Where	ComputerName = @ComputerName
			Or BatNbr = @BatNbr
			Or DateAdd(Day, 2, Crtd_DateTime) < GetDate()



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_ErrorDelete] TO [MSDSL]
    AS [dbo];

