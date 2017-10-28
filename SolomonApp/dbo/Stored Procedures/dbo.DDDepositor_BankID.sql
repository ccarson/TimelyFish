 Create Proc DDDepositor_BankID @Parm1 varchar ( 6) as
    Select * from DDDepositor where BankID like @Parm1 ORDER by BankID, EmpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDDepositor_BankID] TO [MSDSL]
    AS [dbo];

