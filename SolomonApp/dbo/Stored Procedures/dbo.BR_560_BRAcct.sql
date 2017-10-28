 Create Procedure BR_560_BRAcct
AS
Select *
from BRAcct
where active = 1
order by AcctID
--NOTE: Troy Grigsby - 11/29/01 - Modified from the original version where where clause is Active = 'True'



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_560_BRAcct] TO [MSDSL]
    AS [dbo];

