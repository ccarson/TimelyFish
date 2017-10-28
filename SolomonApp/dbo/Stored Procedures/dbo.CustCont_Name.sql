 Create Proc CustCont_Name @parm1 Varchar(10), @parm2 Varchar(15) as
       Select Name from CustContact where ContactID = @Parm1 and custid = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CustCont_Name] TO [MSDSL]
    AS [dbo];

