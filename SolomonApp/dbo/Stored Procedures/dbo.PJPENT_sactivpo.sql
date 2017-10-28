 create procedure PJPENT_sactivpo @parm1 varchar (16) , @PARM2 varchar (32)   as
SELECT    project,
pjt_entity,
pjt_entity_desc,
status_pa,
status_po
FROM      PJPENT
WHERE     project =  @parm1 and
pjt_entity  Like  @parm2 and
status_pa = 'A' and
status_po = 'A'
ORDER BY  project, pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPENT_sactivpo] TO [MSDSL]
    AS [dbo];

