 create procedure PJPROJEM_spk1 @parm1 varchar (16)  as
select pjprojem.*, pjemploy.emp_name, pjemploy.MSPInterface,
	pjemploy.mspres_uid, pjemploy.employee
from pjprojem
	left outer join pjemploy
		on pjprojem.employee = pjemploy.employee
where pjprojem.project = @parm1
order by pjprojem.employee, pjprojem.project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_spk1] TO [MSDSL]
    AS [dbo];

