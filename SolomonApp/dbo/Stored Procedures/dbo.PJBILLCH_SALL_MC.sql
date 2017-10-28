 create procedure  PJBILLCH_SALL_MC @parm1 varchar (16), @parm2 varchar (100), @parm3 varchar (6)
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJBILLCH.* from PJBILLCH
	INNER JOIN PJPROJ
        ON PJBILLCH.project = PJPROJ.Project
where PJBILLCH.project like  @parm1 and
pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm2)) and
PJBILLCH.appnbr  like  @parm3
order by PJBILLCH.project, PJBILLCH.appnbr


