 Create procedure Del_Ar_Balances @parm1 varchar (15) as

Delete from AR_Balances where custid = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Del_Ar_Balances] TO [MSDSL]
    AS [dbo];

