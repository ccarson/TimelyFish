 create procedure PJBSHDR_SPKLIKE_MC  @parm1 varchar (16), @parm2 varchar (100) , @parm3 varchar (6) 
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJBSHDR.* from PJBSHDR
	INNER JOIN PJPROJ
        ON PJPROJ.project = PJBSHDR.Project
where    PJBSHDR.project     LIKE @parm1 and
pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm2)) AND
PJBSHDR.schednbr LIKE @parm3
order by PJBSHDR.project, PJBSHDR.schednbr


