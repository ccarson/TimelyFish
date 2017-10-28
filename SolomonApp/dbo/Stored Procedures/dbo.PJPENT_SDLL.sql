 create procedure PJPENT_SDLL  @parm1 varchar (16) , @parm2 varchar (32)   as
select pjt_entity_desc from PJPENT
where    project    = @parm1
and      pjt_entity = @parm2
order by project,
pjt_entity


