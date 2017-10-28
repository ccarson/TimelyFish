 create procedure PJEMPLOY_spk21 as
select  employee, emp_name   from PJEMPLOY
where   emp_status   =    'A'
order by employee


