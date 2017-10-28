 create procedure PJPROJ_spk5   @parm1 varchar (16) as
-- This procedure is used by 08.010
SELECT * from PJPROJ
WHERE    status_pa = 'A' and
status_ar = 'A' and
project like @parm1
ORDER BY project

