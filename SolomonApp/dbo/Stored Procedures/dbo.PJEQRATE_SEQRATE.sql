 create procedure PJEQRATE_SEQRATE  @parm1 varchar (10) , @parm2 varchar (16) , @parm3 smalldatetime   as
select *
from   PJEQRATE
where  equip_id    =  @parm1
and    project     =  @parm2
and    effect_date =  @parm3


