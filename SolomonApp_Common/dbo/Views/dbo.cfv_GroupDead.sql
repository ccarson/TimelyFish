--*************************************************************
--	Purpose: Pig Group Dead
--	Author: Sue Matter
--	Date: 11/11/2004
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************



CREATE View cfv_GroupDead
AS
Select pg.ProjectID,
       pg.TaskID,
       sum (tr.Qty) AS Qty,
       sum (tr.IndWgt) AS Wgt,
       sum(tr.TotalWgt) AS TWgt
  From cftPigGroup pg WITH (NOLOCK)
  JOIN cftPGInvTran tr WITH (NOLOCK) ON pg.PigGroupID=tr.PigGroupID
  Where tr.acct='PIG DEATH' AND tr.Reversal<>'1'
  Group by pg.ProjectID, pg.TaskID 

 