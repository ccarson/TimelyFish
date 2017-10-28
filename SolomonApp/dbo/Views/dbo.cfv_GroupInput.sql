--*************************************************************
--	Purpose: Pig Group Input
--	Author: Sue Matter
--	Date: 6/9/2005
--	Usage: Pig Group Close
--	Parms: 
--	       
--*************************************************************


CREATE  View cfv_GroupInput
AS
Select pg.ProjectID,
       pg.TaskID,
       sum (tr.Qty) AS Qty,
       sum (tr.IndWgt) AS Wgt,
       sum(tr.TotalWgt) AS TWgt
  From cftPGInvTran tr
  LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
  Where tr.acct IN ('PIG MOVE IN') AND tr.Reversal<>'1'
  AND tr.trandate>DateAdd(day,7,(select Min(TranDate) 
	from cftPGInvTran Where PigGroupID=pg.PigGroupID AND Reversal<>'1' 
	AND acct In('PIG TRANSFER IN','PIG MOVE IN','PIG PURCHASE')))
  Group by pg.ProjectID, pg.TaskID 



 