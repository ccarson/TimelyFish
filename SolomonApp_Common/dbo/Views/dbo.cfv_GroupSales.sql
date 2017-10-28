--*************************************************************
--	Purpose: Pig Group Sales
--	Author: Sue Matter
--	Date: 5/1/2005
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************


CREATE View cfv_GroupSales
AS
Select pg.ProjectID,
       pg.TaskID,
       min(tr.TranDate) as StartDate,
       max(tr.TranDate) as LastSale,
       sum (tr.Qty) AS Qty,
       sum (tr.IndWgt) AS Wgt,
       sum(tr.TotalWgt) AS TWgt
  From cftPigGroup pg WITH (NOLOCK)
  JOIN cftPGInvTran tr WITH (NOLOCK) ON pg.PigGroupID=tr.PigGroupID
  Where tr.acct='PIG SALE' AND tr.Reversal<>'1'
  Group by pg.ProjectID, pg.TaskID 

 