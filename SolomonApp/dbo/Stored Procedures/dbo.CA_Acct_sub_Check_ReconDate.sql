 /****** Object:  Stored Procedure dbo.CA_Acct_sub_Check_ReconDate    Script Date: 4/7/98 12:49:20 PM ******/
create Proc CA_Acct_sub_Check_ReconDate @parm1 varchar(10), @parm2 varchar(10), @parm3 varchar(10), @parm4 varchar(24), @parm5 smalldatetime, @parm6 smalldatetime as
Select * from CATran
Where bankcpnyid like @parm1
and BankAcct like @parm2
and Banksub like @parm3
and ((RcnclStatus = 'O' and TranDate <= @parm4)
or (RcnclStatus = 'C' and (TranDate <= @parm5 and TranDate > @parm6)))
and ((catran.drcr = 'D' and (entryid <> 'TR' and entryid <> 'ZZ'))
or (catran.drcr = 'C' and entryid = 'TR')
or (catran.drcr = 'C' and entryid = 'ZZ' and RTRIM(catran.RefNbr) <> 'OFFSET'))
and catran.rlsed = 1
Order by batnbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[CA_Acct_sub_Check_ReconDate] TO [MSDSL]
    AS [dbo];

