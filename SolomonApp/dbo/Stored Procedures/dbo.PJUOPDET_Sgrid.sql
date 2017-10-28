 create procedure PJUOPDET_Sgrid @parm1 varchar (10) , @parm2beg smallint , @parm2end smallint as
select PJUOPDET.*, PJPENTEX.*
from PJUOPDET
	left outer join PJPENTEX
		on 	pjuopdet.project = pjpentex.project
		and pjuopdet.pjt_entity = pjpentex.pjt_entity
where (docnbr = @parm1 and
	linenbr between @parm2beg and @parm2end)
order by PJUOPDET.docnbr, PJUOPDET.linenbr


