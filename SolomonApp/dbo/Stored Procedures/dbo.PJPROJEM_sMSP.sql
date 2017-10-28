create procedure PJPROJEM_sMSP @Project varchar (16) as
select e.employee, ex.Employee_MSPID 
from 
PJPROJEM p
INNER JOIN
	PJEMPLOY e on p.employee = e.employee 
LEFT OUTER JOIN
	PJEMPLOYXREFMSP ex on p.employee = ex.employee
where 
p.project = @Project and 
e.MSPInterface = 'Y' 


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_sMSP] TO [MSDSL]
    AS [dbo];

