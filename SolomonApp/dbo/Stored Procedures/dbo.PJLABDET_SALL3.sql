 create procedure PJLABDET_SALL3  @parm1 varchar (10) , @parm2beg smallint , @parm2end smallint   as
select  *
from PJLABDET
	left outer join PJPROJ
		on pjlabdet.project = pjproj.project
	left outer join PJPENT
		on pjlabdet.project = pjpent.project
		and pjlabdet.pjt_entity = pjpent.pjt_entity
where docnbr = @parm1 and
	linenbr  between  @parm2beg and @parm2end
order by docnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJLABDET_SALL3] TO [MSDSL]
    AS [dbo];

