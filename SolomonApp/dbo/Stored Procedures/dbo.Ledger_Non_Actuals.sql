 /****** Object:  Stored Procedure dbo.Ledger_Non_Actuals    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc Ledger_Non_Actuals @parm1 varchar ( 10) as
       Select * from Ledger
           where LedgerID   like @parm1
           and (balancetype = "S" or balancetype = "B")
             order by LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ledger_Non_Actuals] TO [MSDSL]
    AS [dbo];

