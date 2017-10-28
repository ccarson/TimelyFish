
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE Procedure pCF522GetStatus @parm1 varchar (16), @parm2 DateTime
AS 
Select hs.*
from cftPGStatHist hs
JOIN cftPigGroup pg ON hs.PigGroupID=pg.PigGroupID 
Where pg.TaskID=@parm1 AND hs.StatusDate=(Select Max(StatusDate) from cftPGStatHist
Where PigGroupID=pg.PigGroupID)
Order by hs.StatusDate


 