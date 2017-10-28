 Create Procedure BR_BRHeader_New
@cpnyid char(10),
@parm1 char(10),
@parm2 char(6)
AS
Select *
from BRHeader
where CpnyID = @Cpnyid
and AcctID = @parm1
and ReconPerNbr = @parm2
order by AcctID, ReconPerNbr


