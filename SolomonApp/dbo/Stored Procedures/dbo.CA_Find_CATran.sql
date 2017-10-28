 /****** Object:  Stored Procedure dbo.CA_Find_CATran    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CA_Find_CATran @parm1 varchar ( 10), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
Select * from CATran
Where bankcpnyid like @parm1
and BankAcct like @parm2
and Banksub like @parm3
and RefNbr = @parm4
and RcnclStatus = 'O'
and rlsed = 1



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Find_CATran] TO [MSDSL]
    AS [dbo];

