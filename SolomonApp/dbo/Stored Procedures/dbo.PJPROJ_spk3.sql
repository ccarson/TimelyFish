 create procedure PJPROJ_spk3  @parm1 varchar (16)  as
-- This procedure is used by 03.010
SELECT * from PJPROJ
WHERE    status_pa = 'A' and
status_ap = 'A' and
project like @parm1
ORDER BY project

