--*************************************************************
--	Purpose: Get the first transaction date
--	Author: Sue Matter
--	Date: 8/19/2004
--	Usage: Batch Release
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************

CREATE    Proc pCF514MinTran
         @parm1 varchar (10)
as
	
SELECT	*
FROM    cftPGInvTran tr
Where tr.acct='PIG MOVE IN' AND tr.Reversal<>'1' AND tr.PigGroupID=@parm1 AND tr.trandate=(Select min(TranDate) 
from cftPGInvTran 
Where acct='PIG MOVE IN' AND Reversal<>'1' AND PigGroupID=@parm1)


 