 create procedure PJEMPLOY_sACTIVE @parm1 varchar (10)  as
select * from PJEMPLOY
where
emp_status   = 'A' and
EMPLOYEE like @parm1
order by employee


