 Create Procedure BR_ARTran
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
and Sub = @parm5
and Rlsed = 1
order by cpnyid, PerPost, Acct, Sub
--NOTE: Troy Grigsby - 11/29/01 - Modified from the original version where where clause is Rlsed = 'True'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_ARTran] TO [MSDSL]
    AS [dbo];

