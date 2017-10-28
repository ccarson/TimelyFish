 create procedure PJEQRATE_SEQUIPR  @parm1 varchar (10) , @parm2 varchar (16)   as
select * from PJEQRATE
where
equip_id  = @parm1 and
project like @parm2
order by equip_id, project, effect_date desc


