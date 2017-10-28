 Create Proc  Employee_DfltEarnType @parm1 varchar ( 10) as
       Select * from Employee
           where DfltEarnType  LIKE  @parm1
           order by EmpId


