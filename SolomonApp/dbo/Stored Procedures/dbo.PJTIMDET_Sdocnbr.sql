 create procedure PJTIMDET_Sdocnbr  @parm1 varchar (10)   as
select *
from   PJTIMDET
where docnbr     =      @parm1
and tl_status <> 'P'
order by docnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_Sdocnbr] TO [MSDSL]
    AS [dbo];

