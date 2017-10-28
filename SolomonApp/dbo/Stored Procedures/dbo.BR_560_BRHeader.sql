 Create Procedure BR_560_BRHeader
@parm1 char(10),
@parm2 char(10),
@parm3 char(6)
AS
Select *
from BRHeader
where AcctID = @parm1 and
cpnyID = @parm2
and ReconPerNbr = @parm3
order by AcctID, cpnyid, ReconPerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_560_BRHeader] TO [MSDSL]
    AS [dbo];

