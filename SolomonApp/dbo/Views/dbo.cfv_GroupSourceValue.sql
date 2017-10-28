--*************************************************************
--	Purpose: Source Location for a Pig Group 
--	Author: Sue Matter
--	Date: 5/1/2005
--	Usage: CF522 Pig Group Costing
--	Parms: 
--	       
--*************************************************************



CREATE         View cfv_GroupSourceValue
AS

Select pg.ProjectID, pg.TaskID, pg.CpnyID, ct.ContactID, ct.ContactName, PM.BatchNbr, PM.RefNbr, tr.TranDate, tr.Qty, sr.Rate, pg2.PigGroupID, pg2.CostFlag
From cftPGInvTran tr
LEFT JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
LEFT JOIN cftSCRate sr ON PM.SourceContactID=sr.SubType AND sr.AcctCat='PIG TRANSFER IN' AND Type='SITE TRANSFER'
LEFT JOIN cftContact ct ON PM.SourceContactID=ct.ContactID
LEFT JOIN cftPigGroup pg2 ON PM.SourcePigGroupID=pg2.PigGroupID
Where tr.TranTypeID In('TI') AND tr.Reversal<>'1'


