--*************************************************************
--	Purpose: Summarize pig group charges
--	Author: Sue Matter
--	Date: 11/04/2004
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID), @parm2 (Transaction Date)
--	       
--*************************************************************


CREATE      PROCEDURE pCF522PigGroupCharge

	AS
	SELECT t.acct, t.PigGroupID, pj.pjt_entity, pj.Project, t.Qty, t.Rlsed
	from cftPGInvTran t
	JOIN cftPigGroup pg on t.PigGroupID=pg.PigGroupID
	JOIN pjpent pj on pg.TaskID=pj.pjt_entity
	Where t.PC_Stat=0
	Order by pj.Project, pj.pjt_entity, t.acct

 