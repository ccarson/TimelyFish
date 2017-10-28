 Create Proc EDCustomerEDI_HeaderDiscCode @CustId varchar(15) As
	Select C.S4Future11, E.Description
		From CustomerEDI C
			Left Outer Join Eddataelement E
				ON C.S4future11 = E.Code
		Where CustId = @Custid

