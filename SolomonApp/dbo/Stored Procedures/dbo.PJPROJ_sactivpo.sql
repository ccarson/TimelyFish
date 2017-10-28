 create procedure PJPROJ_sactivpo  @parm1 varchar (16)  as
-- This proceudre is used by PO Customizations
SELECT   project,
project_desc,
status_pa,
status_po
FROM     PJPROJ
WHERE    status_pa = 'A' and
status_po = 'A' and
project like @parm1
ORDER BY project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_sactivpo] TO [MSDSL]
    AS [dbo];

