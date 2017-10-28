--*************************************************************
--	Purpose: Find the group start date
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************



CREATE       PROCEDURE pCF522TranInStart
		  @parm1 varchar(10)

	AS
	SELECT sum(t.Qty * t.InvEffect)
	from cftPGInvTran t
	Where t.Reversal<>'1' 
	AND (t.Acct='PIG TRANSFER IN' OR t.Acct='PIG PURCHASE') 
--*******Change this 7/21/2005
--*******Do not include moves even if costed we are only trying to establish qty
	--OR (t.Acct='PIG MOVE IN' AND t.PC_Stat='1')
	--OR (t.Acct='PIG MOVE OUT' AND t.PC_Stat='1'))
	AND t.PigGroupID=@parm1 

 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF522TranInStart] TO [MSDSL]
    AS [dbo];

