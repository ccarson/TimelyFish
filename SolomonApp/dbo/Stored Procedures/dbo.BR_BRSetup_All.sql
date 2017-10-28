 Create Procedure BR_BRSetup_All @parm1 varchar (10)
AS
Select *
from BRSetup where CpnyID like @parm1
 order by CpnyId


