--*************************************************************
--	Purpose: Get Total output from Nursery group
--	Author: Sue Matter
--	Date: 3/3/2005
--	Usage: Pig Group Close
--	Parms: 
--	       
--*************************************************************



CREATE            View cfv_GroupCloseNur
AS
Select pg.ProjectID,
       pg.TaskID,
       Sum(tr.Qty) AS Qty,
       Sum(tr.TotalWgt) AS TWgt
   From cftPigGroup pg
  JOIN cftPGInvTran tr ON pg.PigGroupID=tr.PigGroupID
  Where tr.Reversal<>'1' AND (tr.acct='PIG TRANSFER OUT' or tr.acct='PIG MOVE OUT')
  Group by pg.ProjectID, pg.TaskID


 