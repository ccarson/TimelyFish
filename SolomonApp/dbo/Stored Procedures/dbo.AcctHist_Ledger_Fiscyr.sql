 /****** Object:  Stored Procedure dbo.AcctHist_Ledger_Fiscyr    Script Date: 1/11/99 12:45:04 PM ******/
Create Proc AcctHist_Ledger_Fiscyr @parm1 varchar ( 10), @parm2 varchar ( 4) as
       Select * from AcctHist
           where LedgerID like @parm1
             and Fiscyr = @parm2
           order by LedgerID, FiscYr, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[AcctHist_Ledger_Fiscyr] TO [MSDSL]
    AS [dbo];

