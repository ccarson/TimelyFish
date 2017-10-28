 create procedure PJPENT_sactivgl @parm1 varchar (16) , @PARM2 varchar (32)   as
SELECT    project,
pjt_entity,
pjt_entity_desc,
status_pa,
status_gl
FROM      PJPENT
WHERE     project =  @parm1 and
pjt_entity =  @parm2 and
status_pa = 'A' and
status_gl = 'A'
ORDER BY  project, pjt_entity


