 Create Proc  Employee_EmpId_CpnyId @parm1 varchar ( 10), @parm2 varchar ( 10) as
       Select * from Employee
           where CpnyId LIKE  @parm1
             and EmpId  LIKE  @parm2
           order by EmpId


