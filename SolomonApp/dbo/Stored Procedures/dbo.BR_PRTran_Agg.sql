 CREATE Procedure BR_PRTran_Agg
@parm1 char(10),
@parm2 char(6),
@parm3 char(6),
@parm4 char(10),
@parm5 char(24)

as

Select *
from PRTran
where cpnyid = @parm1 and PerPost BETWEEN @parm2 AND @parm3
and Acct = @parm4
and Rlsed = 1
order by PerPost, Acct


