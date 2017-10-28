 create procedure PJPROJ_spk6   @parm1 varchar (16)  as
-- This procecure is used by 01.010
SELECT * from PJPROJ
WHERE    status_pa = 'A' and
status_gl = 'A' and
project like @parm1
ORDER BY project

