 CREATE Proc APDoc_Batch_AcctSub @parm1 VarChar ( 10), @parm2 VarChar ( 24), @parm3 VarChar ( 10)AS
Select * from APDoc where BatNbr = @parm1 And Acct LIKE @parm3 and Sub LIKE @parm2 order by Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[APDoc_Batch_AcctSub] TO [MSDSL]
    AS [dbo];

