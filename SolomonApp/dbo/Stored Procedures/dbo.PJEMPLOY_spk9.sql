 create procedure PJEMPLOY_spk9 @parm1 varchar (250) , @parm2 varchar (10)  as
select * from PJEMPLOY
where
emp_status = 'A' and
EMPLOYEE = @parm2
order by employee


