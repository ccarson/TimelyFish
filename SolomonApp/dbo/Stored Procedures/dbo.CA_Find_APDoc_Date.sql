 create Proc CA_Find_APDoc_Date @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 smalldatetime as
Select * from apdoc
Where cpnyid = @parm1
and acct = @parm2
and sub = @parm3
and RefNbr = @parm4
and DocDate = @parm5
and rlsed = 1
and status <> 'V'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Find_APDoc_Date] TO [MSDSL]
    AS [dbo];

