create procedure PJPROJEM_sMSP2 @Project varchar (16) as
select p.employee 
from 
PJPROJEM p
INNER JOIN
	PJEMPLOY e on p.employee = e.employee 
where 
p.project = @Project and 
e.MSPInterface = 'Y' 

UNION

select s.employee
from
PJPROJEM s
where s.employee = '*' and 
s.project = @Project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEM_sMSP2] TO [MSDSL]
    AS [dbo];

