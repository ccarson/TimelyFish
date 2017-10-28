 Create Proc CATran_Acct_Sub_DepRecon_Bat @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 10), @parm4 varchar ( 24), @parm5 smalldatetime, @parm6 smalldatetime as
Select * from CATran
Where bankcpnyid like @parm1
and BatNbr like @parm2
and BankAcct like @parm3
and Banksub like @parm4
and ((RcnclStatus = 'O' and TranDate <= @parm5)
or (RcnclStatus = 'C' and TranDate <= @parm5 and ClearDate > @parm6))
and ((catran.drcr = 'C' and (entryid <> 'TR' and entryid <> 'ZZ'))
or (catran.drcr = 'D' and entryid = 'TR')
or (catran.drcr = 'D' and entryid = 'ZZ' and RTRIM(catran.RefNbr) <> 'OFFSET'))
and catran.rlsed = 1
Order by BatNbr, RefNbr, trandate, LineNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CATran_Acct_Sub_DepRecon_Bat] TO [MSDSL]
    AS [dbo];

