--*************************************************************
--	Purpose: Find the group start date
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE      PROCEDURE pCF522TranInAll
		  @parm1 varchar(32)

	AS
	Select Qty
	From cfv_GroupStart 
	Where TaskID = @parm1
--	SELECT sum(t.Qty * t.InvEffect)
--	from cftPGInvTran t
--	Where t.Reversal<>'1' AND (t.Acct='PIG TRANSFER IN' OR t.Acct='PIG PURCHASE') AND t.PigGroupID=@parm1 




 