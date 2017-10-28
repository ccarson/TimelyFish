 create procedure PJBILL_SALL_MC  @parm1 varchar (100), @parm2 varchar (16)
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJBILL.* from PJBILL
	Inner Join PJPROJ
		ON PJBILL.Project = PJPROJ.Project
where 
pjproj.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm1))
AND PJBILL.project like @parm2
order by PJBILL.project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJBILL_SALL_MC] TO [MSDSL]
    AS [dbo];

