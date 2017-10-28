 /****** Object:  Stored Procedure dbo.AcctHist_Cpny_Ledger_Fiscyr    Script Date: 4/7/98 12:38:58 PM ******/
Create Proc AcctHist_Cpny_Ledger_Fiscyr @parm1 varchar ( 10), @parm2 varchar(10), @parm3 varchar ( 4) as
       Select * from AcctHist
           where CpnyID like @parm1
             and LedgerID like @parm2
             and Fiscyr = @parm3
           order by CpnyID, LedgerID, FiscYr, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Cpny_Ledger_Fiscyr] TO [MSDSL]
    AS [dbo];

