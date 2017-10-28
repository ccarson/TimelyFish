 CREATE Proc Employee_Name @parm1 varchar ( 10) as
    Select Name from Employee where EmpID = @parm1


