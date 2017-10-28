 Create Proc  Employee_941 @parm1 varchar ( 10) as
       Select * from Employee
           where EmpId in (Select Distinct PRDoc.EmpID 
		   From PRDoc Where prdoc.CalYr=@parm1) 
           order by EmpId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[Employee_941] TO [MSDSL]
    AS [dbo];

