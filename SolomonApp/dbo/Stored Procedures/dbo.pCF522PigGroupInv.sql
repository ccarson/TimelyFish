--*************************************************************
--	Purpose: Find the pig group inventory
--	Author: Sue Matter
--	Date: 11/04/2004
--	Usage: Pig Group Close
--	Parms: @parm1 (Task ID
--	       
--*************************************************************


CREATE  PROCEDURE pCF522PigGroupInv
		  @parm1 varchar(32)

	AS
	SELECT pj.Project, pg.TaskID, sum(t.Qty * t.InvEffect) As TotQty
	from cftPGInvTran t
	JOIN cftPigGroup pg ON t.PigGroupID=pg.PigGroupID
	JOIN PJPENT pj ON pg.TaskID=pj.pjt_entity
	Where pg.PGStatusID<>'I' AND pg.TaskID=@parm1
	Group by pj.Project, pg.TaskID

 