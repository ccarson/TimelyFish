--*************************************************************
--	Purpose: Current Pig Group Inventory
--	Author: Sue Matter
--	Date: 10/25/2004
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************


CREATE View cfvCurrentInvNEW (Project, TaskID, CurrentInv)
 	AS
	SELECT pg.ProjectID, pg.TaskID, Sum(t.Qty * t.InvEffect)
 		from cftPigGroup pg
		LEFT OUTER JOIN cftPGInvTran t ON pg.PigGroupID = t.PigGroupID
		Where t.Reversal<>'1'
		GROUP BY pg.ProjectID, pg.TaskID

 