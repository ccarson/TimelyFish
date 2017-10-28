 Create Proc EDSTCustomer_Clear @CustId varchar(15) As
Delete From EDSTCustomer Where CustId = @CustId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[EDSTCustomer_Clear] TO [MSDSL]
    AS [dbo];

