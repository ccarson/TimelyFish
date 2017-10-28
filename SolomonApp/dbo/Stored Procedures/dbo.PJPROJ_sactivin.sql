 create procedure PJPROJ_sactivin  @parm1 varchar (16)  as
-- This proceudre is used by IN Customizations
SELECT   project,
project_desc,
status_pa,
status_in
FROM     PJPROJ
WHERE    status_pa = 'A' and
status_in = 'A' and
project like @parm1
ORDER BY project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sactivin] TO [MSDSL]
    AS [dbo];

