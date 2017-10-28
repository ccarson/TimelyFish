 /****** Object:  Stored Procedure dbo.Ledger_no_budget    Script Date: 4/7/98 12:38:59 PM ******/
Create Proc Ledger_no_budget @parm1 varchar ( 10) as
Select * from Ledger
where LedgerID   like @parm1
and (balancetype = "S" or balancetype = "A" or balancetype = "R")
order by LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ledger_no_budget] TO [MSDSL]
    AS [dbo];

