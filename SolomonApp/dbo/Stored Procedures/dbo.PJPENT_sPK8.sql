 create procedure PJPENT_sPK8 @parm1 varchar (16) , @PARM2 varchar (32)   as
select project, pjt_entity, pjt_entity_desc, status_pa, status_po from PJPENT
where project =  @parm1 and
pjt_entity  Like  @parm2 and
status_pa = 'A' and
status_po = 'A'
order by project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sPK8] TO [MSDSL]
    AS [dbo];

