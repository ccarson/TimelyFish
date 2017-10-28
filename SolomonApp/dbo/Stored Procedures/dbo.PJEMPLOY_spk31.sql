 create procedure PJEMPLOY_spk31 as
select  employee, emp_name, emp_status   from PJEMPLOY
where   emp_status   =    'A'
order by emp_name


