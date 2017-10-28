--*************************************************************
--	Purpose: Find the current inventory
--	Author: Sue Matter
--	Date: 12/19/2004
--	Usage: Pig Group Close
--	Parms: 
--	       
--*************************************************************



CREATE     PROCEDURE pCF522PigGroupInv_ALL

	AS
	SELECT pj.Project, pg.TaskID, sum(t.Qty * t.InvEffect) As TotQty
	from cftPGInvTran t
	JOIN cftPigGroup pg ON t.PigGroupID=pg.PigGroupID
	JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
	Where pg.PGStatusID<>'I'
	GROUP BY pj.Project, pg.TaskID
	Order by pj.Project, pg.TaskID

 