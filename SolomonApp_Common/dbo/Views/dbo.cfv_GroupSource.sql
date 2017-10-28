--*************************************************************
--	Purpose: Current Pig Group Sources
--	Author: Sue Matter
--	Date: 6/3/2005
--	Usage: CF663 Report
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE     View cfv_GroupSource
AS
Select tr.PigGroupID, pj.project_desc As Source
From cftPGInvTran tr
JOIN cftPgInvXfer xf ON tr.SourceBatNbr=xf.BatNbr AND tr.SourceLineNbr=xf.LineNbr
LEFT JOIN cftPigGroup pg ON tr.SourcePigGroupID=pg.PigGroupID
LEFT JOIN PJPROJ pj ON pg.ProjectID=pj.Project
Where tr.TranTypeID='MI' AND tr.Reversal<>'1'
Group by tr.PigGroupID, pj.project_desc

UNION

Select tr.PigGroupID, pj.project_desc As Source
From cftPGInvTran tr
JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
LEFT JOIN PJPROJ pj ON PM.SourceProject=pj.Project
Where tr.TranTypeID In('TI','PP') 
	AND tr.Reversal<>'1'
Group by tr.PigGroupID, pj.project_desc



 