 create procedure PJTIMDET_Sdoceq  @parm1 varchar (10)   as
select *
from   PJTIMDET
where docnbr     =      @parm1
and equip_id <> ' '
order by docnbr, linenbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_Sdoceq] TO [MSDSL]
    AS [dbo];

