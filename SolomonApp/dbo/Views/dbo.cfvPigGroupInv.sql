--*************************************************************
--	Purpose: Current Pig Group Inventory
--	Author: Sue Matter
--	Date: 5/1/2005
--	Usage: Multiple Applications
--	Parms: 
--	       
--*************************************************************

CREATE    VIEW cfvPigGroupInv (PigGroupID, TranDate, Qty, tstamp)
	AS
	SELECT t.PigGroupID, t.Crtd_DateTime, Sum(t.Qty * t.InvEffect), Min(t.tstamp)
 		from cftPigGroup pg
		LEFT OUTER JOIN cftPGInvTran t ON pg.PigGroupID = t.PigGroupID
		WHERE t.Crtd_DateTime Is NOT NULL AND t.Reversal<>'1'
		GROUP BY t.PigGroupID, t.Crtd_DateTime

 