 Create procedure PJCOPROJ_SSPV_MC @parm1 varchar (16) , @parm2 varchar (100),  @parm3 varchar (16) 
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJCOPROJ.* from PJCOPROJ 
	INNER JOIN PJPROJ 
		ON PJCOPROJ.Project = PJPROJ.Project
where
PJCOPROJ.project like @parm1 and
pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm2)) and 
change_order_num like @parm3
order by project, change_order_num



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJCOPROJ_SSPV_MC] TO [MSDSL]
    AS [dbo];

