 Create Proc Ledger_Actual_only @parm1 varchar ( 10) as
Select * from Ledger
where LedgerID   like @parm1
and balancetype = "A"
order by LedgerID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Ledger_Actual_only] TO [MSDSL]
    AS [dbo];

