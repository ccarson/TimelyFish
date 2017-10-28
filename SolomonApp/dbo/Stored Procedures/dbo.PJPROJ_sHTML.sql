 create procedure PJPROJ_sHTML as
SELECT   p.project,
p.project_desc,
e.project,
e.pjt_entity,
e.pjt_entity_desc
FROM     PJPROJ P,PJPENT E
WHERE    p.project = e.project and
p.status_pa = 'A' and
e.status_pa = 'A'
ORDER BY p.project, e.pjt_entity



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sHTML] TO [MSDSL]
    AS [dbo];

