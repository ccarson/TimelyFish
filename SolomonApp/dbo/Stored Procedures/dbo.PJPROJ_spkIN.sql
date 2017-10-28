 create procedure PJPROJ_spkIN  @parm1 varchar (16)  as
SELECT * from PJPROJ
WHERE    status_in = 'A' and
status_pa = 'A' and
project like @parm1
ORDER BY project

