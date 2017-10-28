 /****** Object:  Stored Procedure dbo.APDoc_Acct_Sub_Class_RefNbr    Script Date: 4/7/98 12:19:54 PM ******/
Create Procedure APDoc_Acct_Sub_Class_RefNbr
@parm1 varchar ( 10), @parm2 varchar ( 24), @parm3 varchar ( 1), @parm4 varchar ( 10) as
Select * from APDoc where Acct = @parm1
and Sub = @parm2
and DocClass = @parm3
and RefNbr like @parm4
and Status <> 'V'
and DocType IN ('CK', 'HC','EP')
Order by Acct, Sub, DocType, RefNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Acct_Sub_Class_RefNbr] TO [MSDSL]
    AS [dbo];

