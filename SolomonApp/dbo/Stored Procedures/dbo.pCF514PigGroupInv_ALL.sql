--*************************************************************
--	Purpose: 
--	Author: Sue Matter
--	Date: 10/19/2004
--	Usage: Sum Inventory for all active groups
--	Parms: 
--	       
--*************************************************************


CREATE     PROCEDURE pCF514PigGroupInv_ALL

	AS
	SELECT pg.TaskID, sum(t.Qty * t.InvEffect) As TotQty
	from cftPGInvTran t
	JOIN cftPigGroup pg ON t.PigGroupID=pg.PigGroupID
	Where pg.PGStatusID<>'I'
	GROUP BY pg.TaskID

 