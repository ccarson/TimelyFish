 /****** Object:  Stored Procedure dbo.AcctHist_FiscYr_Acct_Sub    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AcctHist_FiscYr_Acct_Sub @parm1 varchar ( 4), @parm2 varchar ( 10), @parm3 varchar ( 24), @parm4 varchar ( 10) as
       Select * from AcctHist
           where FiscYr like @parm1
             and Acct   like @parm2
             and Sub    like @parm3
             and LedgerID like @parm4
           order by FiscYr, Acct, Sub, LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_FiscYr_Acct_Sub] TO [MSDSL]
    AS [dbo];

