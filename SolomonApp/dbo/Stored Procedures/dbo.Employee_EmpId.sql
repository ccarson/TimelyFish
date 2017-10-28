 Create Proc  Employee_EmpId @parm1 varchar ( 10) as
       Select * from Employee
           where EmpId  LIKE  @parm1
           order by EmpId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[Employee_EmpId] TO [MSDSL]
    AS [dbo];

