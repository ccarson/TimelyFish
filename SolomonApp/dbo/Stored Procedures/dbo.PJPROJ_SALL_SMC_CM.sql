
create procedure PJPROJ_SALL_SMC_CM  @parm1 varchar(100), @parm2 varchar (4), @parm3 varchar (16)
 with execute as '07718158D19D4f5f9D23B55DBF5DF1'
 as
select pjproj.* from PJPROJ
 where
  pjproj.CpnyId in (select cpnyid from dbo.UserAccessCpny(@parm1)) and
  pjproj.projcuryid = @parm2 and
  pjproj.project like @parm3
 order by pjproj.project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_SALL_SMC_CM] TO [MSDSL]
    AS [dbo];

