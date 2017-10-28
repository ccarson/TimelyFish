 Create Procedure BR_Accounts_Recons
@parm1 char(10),
@parm2 char(10),
@parm3 char(6)
AS
Select *
from BRHeader
where cpnyid = @parm1 and AcctID = @parm2
and ReconPerNbr = @parm3
order by AcctID, ReconPerNbr



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_Accounts_Recons] TO [MSDSL]
    AS [dbo];

