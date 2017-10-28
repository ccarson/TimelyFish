 create procedure PJEMPLOY_sAssign @parm1 varchar (10) as
select *
From PJEMPLOY
Where PJEMPLOY.employee like @parm1 and
     ((PJEMPLOY.emp_status = 'A')
      or
	 (PJEMPLOY.emp_status = 'I' and PJEMPLOY.Placeholder = 'Y' ))


