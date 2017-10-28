 create procedure PJPROJ_sactivgl  @parm1 varchar (16)  as
-- This proceudre is used by GL Customizations
SELECT   project,
project_desc,
status_pa,
status_gl
FROM     PJPROJ
WHERE    status_pa = 'A' and
status_gl = 'A' and
project like @parm1
ORDER BY project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sactivgl] TO [MSDSL]
    AS [dbo];

