 create procedure PJEMPLOY_Smsp as
select * from PJEMPLOY
where emp_status = 'A' and
	MSPInterface <> 'Y'
order by employee


