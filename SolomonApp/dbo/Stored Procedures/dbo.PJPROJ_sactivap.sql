 create procedure PJPROJ_sactivap  @parm1 varchar (16)  as
-- This proceudre is used by AP Customizations
SELECT   project,
project_desc,
status_pa,
status_ap
FROM     PJPROJ
WHERE    status_pa = 'A' and
status_ap = 'A' and
project like @parm1
ORDER BY project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sactivap] TO [MSDSL]
    AS [dbo];

