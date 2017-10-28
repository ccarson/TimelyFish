 create procedure PJPENT_sPK61 @parm1 varchar (16)   as
select project, pjt_entity, pjt_entity_desc, status_pa, status_gl from PJPENT
where project =  @parm1 and
status_pa = 'A' and
status_gl = 'A'
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPK61] TO [MSDSL]
    AS [dbo];

