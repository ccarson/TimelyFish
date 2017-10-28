 Create Procedure BR_Chk_Clrd
@parm1 char(10),
@parm2 char(10),
@parm3 char(6)
AS
Select Sum(TranAmt)
from BRTran
where cpnyid = @parm1 and AcctID = @parm2
and CurrPerNbr = @parm3
and TranAmt < 0.00
and Cleared = 1
--NOTE: Troy Grigsby - 11/29/01 - Modified from the original version where where clause is Cleared = 'True'


