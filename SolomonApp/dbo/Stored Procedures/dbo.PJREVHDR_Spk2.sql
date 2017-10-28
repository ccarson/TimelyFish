 create procedure PJREVHDR_Spk2 @parm1 varchar (16) as
SELECT distinct * from PJREVHDR, PJPROJ
WHERE pjrevhdr.project like @parm1 and
pjrevhdr.project = pjproj.project
ORDER BY pjrevhdr.project


