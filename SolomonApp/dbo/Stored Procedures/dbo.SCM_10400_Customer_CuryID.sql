 Create	Procedure SCM_10400_Customer_CuryID
	@CustID		VarChar(15)
As
	Declare	@CuryID	Char(4)
	Set	@CuryID = Space(4)

	Select	@CuryID = CuryID
		From	Customer (NoLock)
		Where	CustID = @CustID

	Select	CuryID = @CuryID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[SCM_10400_Customer_CuryID] TO [MSDSL]
    AS [dbo];

