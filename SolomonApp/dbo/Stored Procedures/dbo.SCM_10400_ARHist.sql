 Create	Procedure SCM_10400_ARHist
	@CustID		VarChar(15),
	@CpnyID		VarChar(10),
	@FiscYr		Char(4)
As
	Select	*
		From	ARHist (NoLock)
		Where	CustID = @CustID
			And CpnyID = @CpnyID
			And FiscYr = @FiscYr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_ARHist] TO [MSDSL]
    AS [dbo];

