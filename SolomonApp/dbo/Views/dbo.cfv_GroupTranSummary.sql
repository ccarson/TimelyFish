--*************************************************************
--	Purpose: Current Pig Group Transaction Summary
--	Author: Sue Matter
--	Date: 3/1/2005
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************



CREATE             View cfv_GroupTranSummary
AS
Select pg.ProjectID,
       pg.TaskID,
       tr.acct,
       pd.Descr,
       tr.InvEffect,
       Sum(tr.Qty) AS Qty,
       Sum(tr.TotalWgt) AS TWgt,
       Min(tr.trandate)AS FirstTran
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  LEFT JOIN cftPigSale sl ON sl.BatNbr=tr.SourceBatNbr AND sl.RefNbr=tr.SourceRefNbr
  LEFT JOIN cftPSType pd ON pd.SalesTypeID=sl.SaleTypeID
  Where tr.Reversal<>'1'
  Group by pg.ProjectID, pg.TaskID, tr.acct, pd.Descr, tr.InvEffect


 