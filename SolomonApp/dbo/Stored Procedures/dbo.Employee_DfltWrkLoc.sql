 Create Proc  Employee_DfltWrkLoc @parm1 varchar ( 6) as
       Select * from Employee
           where DfltWrkLoc  LIKE  @parm1
           order by EmpId


