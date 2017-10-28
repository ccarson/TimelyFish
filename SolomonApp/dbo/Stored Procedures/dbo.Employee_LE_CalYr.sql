 Create Proc  Employee_LE_CalYr @parm1 varchar ( 4) as
       Select * from Employee
           where CalYr  <=  @parm1
           order by EmpId


