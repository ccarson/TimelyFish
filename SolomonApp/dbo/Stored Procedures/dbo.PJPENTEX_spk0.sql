 create procedure PJPENTEX_spk0 @parm1 varchar (16) , @parm2 varchar (32)   as
select *
from PJPENTEX
	left outer join PJPENT
		on PJPENTEX.project = PJPENT.project
		and PJPENTEX.pjt_entity = PJPENT.pjt_entity
where PJPENTEX.project =  @parm1
	  and PJPENTEX.pjt_entity like @parm2
order by PJPENTEX.project, PJPENTEX.pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENTEX_spk0] TO [MSDSL]
    AS [dbo];

