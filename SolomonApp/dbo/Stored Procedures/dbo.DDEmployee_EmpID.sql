 Create Proc DDEmployee_EmpID @parm1 varchar ( 10) as
    Select * from Employee where EmpId LIKE @parm1 order by EmpId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[DDEmployee_EmpID] TO [MSDSL]
    AS [dbo];

