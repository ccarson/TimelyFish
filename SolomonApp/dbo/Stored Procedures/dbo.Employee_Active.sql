 Create Proc Employee_Active @parm1 varchar ( 10) as
Select count(empid) from Employee
where Status = "A" and Empid <> @parm1 and (PayType <> "H" or (PayType = "H" and EXISTS
(select * from PRTran where PRTran.Empid = Employee.Empid and PRTran.paid = 0 and PRTran.TimeShtFlg <> 0)))


