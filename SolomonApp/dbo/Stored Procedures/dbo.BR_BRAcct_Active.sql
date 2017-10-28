 Create Procedure BR_BRAcct_Active @parm1 varchar(10)
AS
Select *
from BRAcct
where Active = 1 and cpnyid = @parm1
order by cpnyId, AcctID
--NOTE: Troy Grigsby - 11/29/01 - Modified from the original version where where clause is Active = 'True'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_BRAcct_Active] TO [MSDSL]
    AS [dbo];

