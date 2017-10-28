--*************************************************************
--	Purpose: Current Pig Group Transactions
--	Author: Sue Matter
--	Date: 10/4/2004
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************



CREATE           View cfv_GroupTran
AS
Select pg.ProjectID,
       pg.TaskID,
       tr.acct,
       tr.InvEffect,
       sum (tr.Qty) AS Qty,
       sum (tr.TotalWgt) AS Wgt
  From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  Where tr.Reversal<>'1'
  Group by pg.ProjectID, pg.TaskID, tr.acct, tr.InvEffect 


