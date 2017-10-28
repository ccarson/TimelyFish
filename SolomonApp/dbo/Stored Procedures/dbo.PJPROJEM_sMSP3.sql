
create procedure PJPROJEM_sMSP3 @Employee varchar (10) as
select pm.project, p.cpnyid, px.Project_MSPID 
from 
PJPROJEM pm
INNER JOIN
	PJPROJ p on pm.project = p.project 
INNER JOIN
	PJPROJXREFMSP px on pm.project = px.project
where 
pm.employee = @Employee and 
p.MSPInterface = 'Y' 

GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_sMSP3] TO [MSDSL]
    AS [dbo];

