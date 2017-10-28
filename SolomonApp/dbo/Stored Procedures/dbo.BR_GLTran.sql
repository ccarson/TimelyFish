 Create Procedure BR_GLTran
@parm1 char(10),
@parm2 char(6),
@parm3 char(6),
@parm4 char(10),
@parm5 char(24)
as
Select *
from GLTran
where Module = 'GL'
and cpnyid = @parm1 and PerPost BETWEEN @parm2 AND @parm3
and Acct = @parm4
and Sub = @parm5
and Rlsed = 1
and LedgerID = (SELECT LedgerID FROM GLSetup)
order by cpnyid, Module, PerPost, Acct, Sub
--NOTE: Troy Grigsby - 11/29/01 - Modified from the original version where where clause is Rlsed = 'True'


