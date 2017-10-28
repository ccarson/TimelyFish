 Create Procedure BR_Accounts_All
@parm1 char(10),@parm2 char(10)
AS Select *
from BRAcct
where cpnyid = @parm1 and AcctID like @parm2
order by AcctID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_Accounts_All] TO [MSDSL]
    AS [dbo];

