 create procedure PJPENT_sPK2 @parm1 varchar (16) , @PARM2 varchar (1)   as
select t.*, p.*, e.*
from PJPENT t
	left outer join PJEMPLOY e
		on t.manager1 = e.employee
	, PJproj p
where p.project like @parm1
	and p.project = t.project
	and t.status_pa like @parm2
order by t.project, t.pjt_entity


