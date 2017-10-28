--*************************************************************
--	Purpose: Pig Group Inventory Transactions
--	Author: Sue Matter
--	Date: 4/21/2005
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************


CREATE  View cfv_GroupTranDetails
AS
Select pg.ProjectID,
       pg.TaskID,
       tr.acct,
       tr.InvEffect,
       tr.TranDate,
       tr.BatNbr,
       tr.TranTypeID,
       tr.TranSubTypeID,
       tr.SourcePigGroupID,
       tr.SourceBatNbr,
       tr.SourceLineNbr,
       tr.SourceRefNbr,
       tr.Qty,
       tr.TotalWgt,
       PM.DocType,
       PM.DestProject,
       PM.DestTask,
       PM.PMID AS LoadNbr,
       xf.DestPigGroupID
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON (pg.PigGroupID=tr.PigGroupID or pg.PigGroupID=tr.SourcePigGroupID)
  LEFT JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
  LEFT JOIN cftPgInvXfer xf ON tr.SourceBatNbr=xf.BatNbr AND tr.SourceLineNbr=xf.LineNbr
  Where tr.Reversal<>'1'

 