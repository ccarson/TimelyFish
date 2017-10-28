 Create Procedure BR_560_BRSetup
AS
Select *
from BRSetup
order by SetupID



GO
GRANT CONTROL
    ON OBJECT::[dbo].[BR_560_BRSetup] TO [MSDSL]
    AS [dbo];

