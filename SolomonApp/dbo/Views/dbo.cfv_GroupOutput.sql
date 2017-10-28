--*************************************************************
--	Purpose: Current Pig Group Output Transactions
--	Author: Sue Matter
--	Date: 6/3/2005
--	Usage: Multiple Reports
--	Parms: 
--	       
--*************************************************************



CREATE         View cfv_GroupOutput
AS
Select pg.ProjectID,
       pg.TaskID,
       sum (tr.Qty) AS Qty,
       sum (tr.IndWgt) AS Wgt,
       sum(tr.TotalWgt) AS TWgt
  From cftPGInvTran tr
  LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
  Where (tr.acct='PIG MOVE OUT' or tr.acct='PIG TRANSFER OUT') AND tr.Reversal=0
  AND tr.trandate>DateAdd(day,7,(select Min(TranDate) 
	from cftPGInvTran Where PigGroupID=pg.PigGroupID AND Reversal=0
	AND acct In('PIG TRANSFER IN','PIG MOVE IN','PIG PURCHASE')))
  Group by pg.ProjectID, pg.TaskID 

 
