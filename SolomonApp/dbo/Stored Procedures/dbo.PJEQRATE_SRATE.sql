 create procedure PJEQRATE_SRATE  @parm1 varchar (10) , @parm2 varchar (16) , @parm3 smalldatetime   as
select *
from   PJEQRATE
where    equip_id    =   @parm1
and    project     =   @parm2
and    effect_date <=  @parm3
order by      equip_id,
project,
effect_date desc


