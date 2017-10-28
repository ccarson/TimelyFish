 /****** Object:  Stored Procedure dbo.Ledger_All    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc Ledger_All @parm1 varchar ( 10) as
       Select * from Ledger
           where LedgerID   like @parm1
             order by LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ledger_All] TO [MSDSL]
    AS [dbo];

