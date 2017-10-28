 create procedure PJBSHDR_SRELEASE  @parm1 varchar (16) , @parm2 varchar (6)   as
select count(S1.rel_status)
from (Select rel_status
	from pjbsdet
	where project = @parm1 and schednbr = @parm2 and rel_status = 'Y'
  union
	Select rel_status
	from pjbsrev
	where project = @parm1 and schednbr = @parm2 and rel_status = 'Y') as S1


