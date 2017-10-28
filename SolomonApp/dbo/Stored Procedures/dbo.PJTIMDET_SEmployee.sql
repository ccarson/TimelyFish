 create procedure PJTIMDET_SEmployee  @parm1 varchar (10)   as
select DISTINCT(employee), sum(reg_hours), sum(ot1_hours), sum(ot2_hours), sum(tl_id18)
from   PJTIMDET
where docnbr = @parm1
and tl_status <> 'P'
group by  employee



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJTIMDET_SEmployee] TO [MSDSL]
    AS [dbo];

