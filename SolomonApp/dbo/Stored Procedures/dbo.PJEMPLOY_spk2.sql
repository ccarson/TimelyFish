 create procedure PJEMPLOY_spk2 @parm1 varchar (10)  as
select * from PJEMPLOY
where    employee     like @parm1
and    emp_status   =    'A'
order by employee


