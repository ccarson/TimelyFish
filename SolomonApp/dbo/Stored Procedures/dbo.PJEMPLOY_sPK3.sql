 create procedure PJEMPLOY_sPK3 @parm1 varchar (10)  as
select employee, emp_name, emp_status from PJEMPLOY
where EMPLOYEE = @parm1 AND
EMP_Status = 'A'
order by employee


