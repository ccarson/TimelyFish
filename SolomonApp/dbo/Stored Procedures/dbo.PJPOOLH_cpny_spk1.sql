 Create Proc PJPOOLH_cpny_spk1 @parm1 varchar (10), @parm2 varchar (6), @parm3 varchar (6) as
  select * from pjpoolh
   where
    cpnyid = @parm1 and
    grpid = @parm2 and
    period = @parm3



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLH_cpny_spk1] TO [MSDSL]
    AS [dbo];

