 create procedure PJPROJ_spkpo_nowo    @parm1 varchar (16) as
-- This procedure is used by 04.010, 04.250
SELECT * from PJPROJ
WHERE    status_pa = 'A' and
status_po = 'A' and
status_20 = '' and
project like @parm1
ORDER BY project

