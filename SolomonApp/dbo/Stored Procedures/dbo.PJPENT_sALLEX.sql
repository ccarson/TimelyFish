 create procedure PJPENT_sALLEX @parm1 varchar (16) , @parm2 varchar (32)   as
select *
from PJPENT
	left outer join PJPENTEX
		on pjpent.project = pjpentex.project
		and pjpent.pjt_entity = pjpentex.pjt_entity
where pjpent.project = @parm1 and
	pjpent.pjt_entity like @parm2
order by pjpent.project, pjpent.pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sALLEX] TO [MSDSL]
    AS [dbo];

