 create procedure PJREVHDR_SPK2_MC @parm1 varchar(100), @parm2 varchar (16) as
SELECT distinct * from PJREVHDR, PJPROJ
WHERE PJPROJ.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm1))
and pjrevhdr.project like @parm2 and
pjrevhdr.project = pjproj.project
ORDER BY pjrevhdr.project


