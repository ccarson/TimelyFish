 create Proc CA_Find_CATran_Date @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10), @parm5 smalldatetime as
Select * from CATran
Where bankcpnyid like @parm1
and BankAcct like @parm2
and Banksub like @parm3
and RefNbr = @parm4
and TranDate = @parm5
and RcnclStatus = 'O'
and rlsed = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Find_CATran_Date] TO [MSDSL]
    AS [dbo];

