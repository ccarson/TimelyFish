 create procedure PJPROJ_sProjAct  @parm1 varchar (16)  as
SELECT   *
FROM     PJPROJ
WHERE    project = @parm1 and
status_pa = 'A'
ORDER BY project

