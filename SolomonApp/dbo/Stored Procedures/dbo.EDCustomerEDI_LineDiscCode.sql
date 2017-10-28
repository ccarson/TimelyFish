 Create Proc EDCustomerEDI_LineDiscCode @CustId varchar(15) As
	Select C.S4Future12, E.Description
		From CustomerEDI C
			Left Outer Join Eddataelement E
				ON C.S4future12 = E.Code
		Where CustId = @Custid



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCustomerEDI_LineDiscCode] TO [MSDSL]
    AS [dbo];

