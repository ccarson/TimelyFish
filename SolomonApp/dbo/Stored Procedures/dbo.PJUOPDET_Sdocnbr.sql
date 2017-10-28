 create procedure PJUOPDET_Sdocnbr  @parm1 varchar (10)   as
select  *
from   PJUOPDET
where   docnbr     =      @parm1
order by  docnbr,  linenbr


