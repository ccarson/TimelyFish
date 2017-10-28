--*************************************************************
--	Purpose: Pig Group Source Details
--	Author: Sue Matter
--	Date: 11/19/2004
--	Usage: CF663
--	Parms: 
--	       
--*************************************************************


CREATE      View cfv_GroupSourceDetail
AS
Select tr.PigGroupID, pj.Project, pj.project_desc As Source, SUM(xf.Qty) AS Qty
From cftPGInvTran tr
JOIN cftPgInvXfer xf ON tr.SourceBatNbr=xf.BatNbr AND tr.SourceLineNbr=xf.LineNbr
LEFT JOIN cftPigGroup pg ON tr.SourcePigGroupID=pg.PigGroupID
LEFT JOIN PJPROJ pj ON pg.ProjectID=pj.Project
Where tr.TranTypeID='MI' AND tr.Reversal<>'1'
Group by tr.PigGroupID, pj.project_desc, pj.Project

UNION

Select tr.PigGroupID, pj.Project, pj.project_desc As Source, SUM(tr.Qty) As Qty
From cftPGInvTran tr
JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
LEFT JOIN PJPROJ pj ON PM.SourceProject=pj.Project
Where tr.TranTypeID In('TI','PP') 
	AND tr.Reversal<>'1'
Group by tr.PigGroupID, pj.project_desc, PM.DestFarmQty, pj.Project


