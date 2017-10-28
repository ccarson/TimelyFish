 Create Procedure BR_BRAcct_All
@parm1 varchar(10),
@parm2 varchar(10)
AS
Select *
from BRAcct
where cpnyid like @parm1 and AcctID like @parm2
order by AcctID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_BRAcct_All] TO [MSDSL]
    AS [dbo];

