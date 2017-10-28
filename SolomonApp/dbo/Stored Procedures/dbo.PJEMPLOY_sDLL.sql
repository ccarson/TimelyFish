 create procedure PJEMPLOY_sDLL @parm1 varchar (10)  as
select emp_name from PJEMPLOY
where EMPLOYEE = @parm1
order by employee


