 create procedure PJTIMDET_Sgrid  @parm1 varchar (10) , @parm2beg smallint , @parm2end smallint   as
select *
from   PJTIMDET
where (docnbr     =      @parm1 and
linenbr  between  @parm2beg and @parm2end)
order by PJTIMDET.docnbr, PJTIMDET.linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_Sgrid] TO [MSDSL]
    AS [dbo];

