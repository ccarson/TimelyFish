--*************************************************************
--	Purpose: Pig Group Details by date
--	Author: Sue Matter
--	Date: 12/5/2004
--	Usage: George Spreadsheet with current group activity
--	Parms: 
--	       
--*************************************************************


CREATE VIEW cfvPigGroupInv_Tran (PigGroupID, TranDate, Qty)
	AS
	SELECT t.PigGroupID, t.TranDate, Sum(t.Qty * t.InvEffect)
 		from cftPigGroup pg WITH (NOLOCK)
		LEFT OUTER JOIN cftPGInvTran t WITH (NOLOCK) ON pg.PigGroupID = t.PigGroupID
		WHERE t.TranDate Is NOT NULL AND t.Reversal<>'1'
		GROUP BY t.PigGroupID, t.TranDate

 