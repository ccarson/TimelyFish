 Create Procedure BR_Trans_Recons
@cpnyid char(10),
@parm1 char(10),
@parm2 char(6),
@parm3 varchar(40)
AS
Select *
from BRTran
where CpnyID = @CpnyID
and AcctID = @parm1
and CurrPerNbr = @parm2
and Mainkey like @parm3
order by AcctID, CurrPerNbr, MainKey


