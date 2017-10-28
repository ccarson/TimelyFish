 create procedure PJPROJ_spk8  @parm1 varchar (16)  as
-- This procedure is used by ??????
SELECT * from PJPROJ
WHERE    status_pa = 'A' and
status_po = 'A' and
project like @parm1
ORDER BY project

