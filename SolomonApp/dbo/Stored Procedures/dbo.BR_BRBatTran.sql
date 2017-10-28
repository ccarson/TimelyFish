 Create Procedure BR_BRBatTran
@parm1 char(40)
AS
Select *
from BRBatTran
where MainKey = @parm1
order by MainKey


