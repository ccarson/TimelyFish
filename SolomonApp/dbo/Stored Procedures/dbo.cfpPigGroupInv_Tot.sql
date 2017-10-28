--*************************************************************
--	Purpose:Update cftPGInvTran records for Reversals
--	Author: Sue Matter
--	Date: 12/12/2004
--	Usage: Retreive current Pig Group Inventory 
--	Parms: @parm1 (PigGroupID)
--	      
--*************************************************************

CREATE  PROCEDURE cfpPigGroupInv_Tot
		@parm1 varchar (10)
	AS
	SELECT sum(t.Qty * t.InvEffect) As TotQty  
		from cftPGInvTran t
		Where t.Reversal<>'1' AND t.PigGroupID=@parm1
		GROUP BY t.PigGroupID



 