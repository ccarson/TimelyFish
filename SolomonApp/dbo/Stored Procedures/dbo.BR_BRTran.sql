 Create Procedure BR_BRTran
@parm1 char(40)
AS
Select *
from BRTran
where MainKey = @parm1
order by MainKey


