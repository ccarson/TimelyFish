 Create Proc Ledger_budget_only @parm1 varchar ( 10) as
Select * from Ledger
where LedgerID   like @parm1
and balancetype = "B"
order by LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ledger_budget_only] TO [MSDSL]
    AS [dbo];

