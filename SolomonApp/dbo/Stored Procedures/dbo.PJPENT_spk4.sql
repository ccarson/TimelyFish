 create procedure PJPENT_spk4 @parm1 varchar (16) , @parm2 varchar (32)   as
select *
from PJPENT
	left outer join PJEMPLOY
		on PJPENT.manager1 = PJEMPLOY.employee
	left outer join PJPENTEX
		on PJPENT.project = PJPENTEX.project
		and PJPENT.pjt_entity = PJPENTEX.pjt_entity
where pjpent.project = @parm1
	and pjpent.pjt_entity like @parm2
order by pjpent.project, pjpent.pjt_entity


