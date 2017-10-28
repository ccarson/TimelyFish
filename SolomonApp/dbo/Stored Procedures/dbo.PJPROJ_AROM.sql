 create procedure PJPROJ_AROM   @parm1 varchar (16) as
SELECT * from PJPROJ
WHERE    status_pa = "A" and
status_ar = "A" and
project like @parm1
ORDER BY project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_AROM] TO [MSDSL]
    AS [dbo];

