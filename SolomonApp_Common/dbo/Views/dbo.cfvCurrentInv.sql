--*************************************************************
--	Purpose: Current Pig Group Inventory
--	Author: Sue Matter
--	Date: 5/1/2005
--	Usage: Multiple Applications
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************



CREATE   View cfvCurrentInv (Project, TaskID, CurrentInv)
 	AS
	SELECT pg.ProjectID, pg.TaskID, Sum(t.Qty * t.InvEffect)
 		from cftPigGroup pg WITH (NOLOCK)
		LEFT OUTER JOIN cftPGInvTran t WITH (NOLOCK) ON pg.PigGroupID = t.PigGroupID
		Where t.Reversal<>1
		GROUP BY pg.ProjectID, pg.TaskID

