 Create procedure Del_Customers @parm1 varchar (15) as

Delete from Customer where custid = @parm1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Del_Customers] TO [MSDSL]
    AS [dbo];

