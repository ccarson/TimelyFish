--*************************************************************
--	Purpose: Min and Max Birth Age
--	Author: Sue Matter
--	Date: 11/19/2004
--	Usage: Active Site Report
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE           View cfv_GroupMBirth
AS
Select tr.PigGroupID, Min(CAST(pm.BirthDate1 AS Int)) As FirstBirth, Max(CAST(pm.BirthDate2 AS Int)) As LastBirth
From cftPGInvTran tr
JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
Where tr.TranTypeID='TI' AND LTRIM(pm.BirthDate1)>'' AND LTRIM(pm.BirthDate2)>''
Group by tr.PigGroupID



 