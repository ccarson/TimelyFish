--*************************************************************
--	Purpose: Average Birth Age
--	Author: Sue Matter
--	Date: 1/12/2005
--	Usage: Current Inventory Spreadsheets
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE            View cfv_GroupMAvgBirth
AS
Select tr.PigGroupID, 
Sum(((CONVERT (NUMERIC(3,0),pm.BirthDate1)+ CONVERT (NUMERIC(3,0),pm.BirthDate2))/2)* Qty) As WgtdDate, Sum(Qty) As WgtQty
From cftPGInvTran tr
JOIN cftPMTranspRecord PM ON tr.SourceBatNbr=PM.BatchNbr AND tr.SourceRefNbr=PM.RefNbr
LEFT JOIN cftPigGroup pg ON tr.PigGroupID=pg.PigGroupID
Where tr.TranTypeID='TI' AND LTrim(pm.BirthDate1)>' ' AND tr.Reversal<>'1' AND LTrim(pm.BirthDate2)>' '
Group by tr.PigGroupID


 