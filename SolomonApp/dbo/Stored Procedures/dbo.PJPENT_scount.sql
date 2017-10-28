 create procedure PJPENT_scount @parm1 varchar (16)     as
select count(*), max(pjt_entity) from PJPENT
where project =  @parm1


