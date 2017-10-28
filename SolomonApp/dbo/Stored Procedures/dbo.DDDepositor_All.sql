 Create Proc DDDepositor_All @parm1 varchar ( 10) as
    Select * from DDDepositor where EmpID like @parm1 ORDER by EmpID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDDepositor_All] TO [MSDSL]
    AS [dbo];

