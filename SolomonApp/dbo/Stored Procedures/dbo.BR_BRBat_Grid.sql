 Create Procedure BR_BRBat_Grid
@parm1 char(10),
@parm2 char(40)
AS
Select *
from BRBatTran
where AcctID = @parm1
and BatTranID = @parm2
order by AcctID, ARBatNbr, MainKey


