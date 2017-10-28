--*************************************************************
--	Purpose: Pig Group Inventory TailEnder
--	Author: Sue Matter
--	Date: 3/7/2005
--	Usage: XP611
--	Parms: 
--	       
--*************************************************************



CREATE       View cfv_GroupTE
AS
Select pg.ProjectID,
       pg.TaskID,
       sum (tr.Qty) AS Qty,
       sum (tr.IndWgt) AS Wgt,
       sum(tr.TotalWgt) AS TWgt
  From cftPGInvTran tr
  LEFT JOIN cftPigGroup pg ON tr.SourcePigGroupID=pg.PigGroupID
  LEFT JOIN cftPigGroup pg2 ON tr.PigGroupID=pg2.PigGroupID
  Where (tr.acct='PIG MOVE IN' or tr.acct='PIG TRANSFER IN') AND pg2.PigProdPhaseID='TEF' AND tr.Reversal<>'1'
  Group by pg.ProjectID, pg.TaskID 



 