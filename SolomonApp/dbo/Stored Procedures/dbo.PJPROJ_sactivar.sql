 create procedure PJPROJ_sactivar  @parm1 varchar (16)  as
-- This proceudre is used by AR Customizations
SELECT   project,
project_desc,
status_pa,
status_ar
FROM     PJPROJ
WHERE    status_pa = 'A' and
status_ar = 'A' and
project like @parm1
ORDER BY project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sactivar] TO [MSDSL]
    AS [dbo];

