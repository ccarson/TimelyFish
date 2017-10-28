 create procedure Employee_spk0 @parm1 varchar (10)  as
select * from Employee
where EmpId = @parm1
order by EmpId


