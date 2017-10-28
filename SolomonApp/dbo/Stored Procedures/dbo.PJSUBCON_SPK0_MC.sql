 Create procedure PJSUBCON_SPK0_MC  @parm1 varchar (16), @parm2 varchar (100), @parm3 varchar (16)   
 WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' as
select PJSUBCON.* from PJSUBCON
	Inner Join PJPROJ
		On PJSUBCON.project = PJPROJ.Project
where    PJSUBCON.project     LIKE @parm1 and
PJPROJ.CpnyId IN (SELECT cpnyid FROM dbo.UserAccessCpny(@parm2)) and
PJSUBCON.subcontract LIKE @parm3
order by project, subcontract



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJSUBCON_SPK0_MC] TO [MSDSL]
    AS [dbo];

