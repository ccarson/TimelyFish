 Create Proc PJPOOLH_spk1 @parm1 varchar (6), @parm2 varchar (6) as
  select * from pjpoolh
   where
    grpid = @parm1 and
    period = @parm2



GO
GRANT CONTROL
    ON OBJECT::[dbo].[PJPOOLH_spk1] TO [MSDSL]
    AS [dbo];

