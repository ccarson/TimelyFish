
Create Proc DDDepositor_BankID_CpnyID @Parm1 varchar ( 6), @Parm2 varchar ( 10) as
    Select d.* from DDDepositor d join Employee e on d.EmpID = e.EmpID where BankID like @Parm1 AND e.CpnyID like @Parm2 ORDER by BankID, d.EmpID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDDepositor_BankID_CpnyID] TO [MSDSL]
    AS [dbo];

