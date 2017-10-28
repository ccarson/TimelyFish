 create procedure PJPROJ_spkLB  @parm1 varchar (16)  as
SELECT * from PJPROJ
WHERE
status_pa = 'A' and
status_lb = 'A' and
project like @parm1
ORDER BY
project

