 /****** Object:  Stored Procedure dbo.CA_Acct_Sub_Dep_ReconDate    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CA_Acct_Sub_Dep_ReconDate @parm1 varchar(10), @parm2 varchar(10), @parm3 varchar(24), @parm4 smalldatetime , @parm5 smalldatetime as
Select * from CATran
Where bankcpnyid like @parm1
and BankAcct like @parm2
and Banksub like @parm3
and ((RcnclStatus = 'O' and TranDate <= @parm4)
or (RcnclStatus = 'C' and (TranDate <= @parm4 and TranDate > @parm5)))
and ((catran.drcr = 'C' and (entryid <> 'TR' and entryid <> 'ZZ'))
or (catran.drcr = 'D' and entryid = 'TR')
or (catran.drcr = 'D' and entryid = 'ZZ' and RTRIM(catran.RefNbr) <> 'OFFSET'))
and catran.rlsed = 1
Order by batnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Acct_Sub_Dep_ReconDate] TO [MSDSL]
    AS [dbo];

