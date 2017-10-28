 CREATE Procedure BR_ARTran_Agg
@parm1 char(10),
@parm2 char(6),
@parm3 char(6),
@parm4 char(10),
@parm5 char(24)

as

Select *
from ARTran
where cpnyid = @parm1 and PerPost BETWEEN @parm2 AND @parm3
and Acct = @parm4
and Rlsed = 1
order by cpnyid, PerPost, Acct, Sub



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_ARTran_Agg] TO [MSDSL]
    AS [dbo];

