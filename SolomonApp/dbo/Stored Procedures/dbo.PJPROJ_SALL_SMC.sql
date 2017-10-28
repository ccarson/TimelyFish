 create procedure PJPROJ_SALL_SMC  @parm1 varchar(100), @parm2 varchar (16)
  WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
 as
select * from PJPROJ
where 		
pjproj.CpnyId  in (select cpnyid from dbo.UserAccessCpny(@parm1)) and
pjproj.project like @parm2
order by project



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJ_SALL_SMC] TO [MSDSL]
    AS [dbo];

