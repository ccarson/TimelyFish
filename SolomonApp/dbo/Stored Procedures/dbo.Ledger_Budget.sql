 /****** Object:  Stored Procedure dbo.Ledger_Budget    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc Ledger_Budget @parm1 varchar ( 10) as
       Select * from Ledger
           where LedgerID   like @parm1
           and balancetype = "B"
             order by LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ledger_Budget] TO [MSDSL]
    AS [dbo];

