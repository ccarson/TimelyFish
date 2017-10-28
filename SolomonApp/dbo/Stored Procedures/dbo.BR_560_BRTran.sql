 Create Procedure BR_560_BRTran
@parm1 char(10),
@parm2 char(6)
AS
Select *
from BRTran
where AcctID = @parm1
and CurrPerNbr = @parm2
and Cleared = 0
order by AcctID, CurrPerNbr, MainKey
--NOTE: Troy Grigsby - 11/29/01 - Modified from the original version where where clause is Cleared = 'False'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_560_BRTran] TO [MSDSL]
    AS [dbo];

