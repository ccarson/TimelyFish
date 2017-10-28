 Create Proc EDSTCustomer_CheckRef @CustId varchar(15), @EDIShipToRef varchar(17) As
Select Count(*) From EDSTCustomer Where CustId = @CustId And EDIShipToRef = @EDIShipToRef



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSTCustomer_CheckRef] TO [MSDSL]
    AS [dbo];

