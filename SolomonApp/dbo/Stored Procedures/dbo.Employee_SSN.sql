 Create Proc  Employee_SSN @parm1 varchar ( 9), @parm2 varchar ( 10) as
       Select * from Employee
           where SSN  =  @parm1 and empid <> @parm2


