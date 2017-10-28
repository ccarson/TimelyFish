 create procedure PJPENT_sPK31 @parm1 varchar (16)   as
select project, pjt_entity, pjt_entity_desc, status_pa, status_ap from PJPENT
where project =  @parm1 and
status_pa = 'A' and
status_ap = 'A'
order by project, pjt_entity


