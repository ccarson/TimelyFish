 create procedure PJPROJ_spkpo    @parm1 varchar (16) as
-- This procedure is used by 04.010, 04.250
SELECT * from PJPROJ
WHERE    status_pa = 'A' and
status_po = 'A' and
project like @parm1
ORDER BY project

