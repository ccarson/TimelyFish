 Create Proc EDCustomerEDI_Single @CustId varchar(15) As
Select * From CustomerEDI Where
CustId = @CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDCustomerEDI_Single] TO [MSDSL]
    AS [dbo];

