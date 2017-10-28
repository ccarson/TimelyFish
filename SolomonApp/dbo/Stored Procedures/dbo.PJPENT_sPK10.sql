 create procedure PJPENT_sPK10 @parm1 varchar (16) , @PARM2 varchar (32)   as
select project, pjt_entity, pjt_entity_desc, status_pa, status_in from PJPENT
where project =  @parm1 and
pjt_entity  Like  @parm2 and
status_pa = 'A' and
status_in = 'A'
order by project, pjt_entity


