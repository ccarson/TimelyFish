 create procedure PJPROJEX_srev  @parm1 varchar (16), @parm2 varchar (24), @parm3 varchar(4), @parm4 varchar (10), @parm5 varchar(100) 
   WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1' 
  as
select * from PJPROJEX, PJPROJ
where
pjproj.project like @parm1 and
pjproj.gl_subacct like @parm2 and
pjproj.ProjCuryID = @parm3 and
pjproj.cpnyid = @parm4 and
(pjproj.status_pa = 'A' or pjproj.status_pa = 'I') and
pjproj.project = pjprojex.project and
pjprojex.rev_flag = 'Y' and 
PJPROJ.CpnyId in
(select cpnyid from dbo.UserAccessCpny(@parm5))   

order by pjproj.project


GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPROJEX_srev] TO [MSDSL]
    AS [dbo];

