CREATE  View cfvCurrentInvOld (Project, TaskID, CurrentInv)
 	AS
	SELECT pg.ProjectID, pg.TaskID, Sum(t.Qty * t.InvEffect)
 		from cftPigGroup pg
		LEFT OUTER JOIN cftPGInvTran t ON pg.PigGroupID = t.PigGroupID
	        GROUP BY pg.ProjectID, pg.TaskID

