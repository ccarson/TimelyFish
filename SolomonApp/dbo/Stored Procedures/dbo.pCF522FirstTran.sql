--*************************************************************
--	Purpose: Find first inventory transaction for a group
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************




CREATE   Proc pCF522FirstTran
         @parm1 varchar (10)
as
	
SELECT	min(TranDate) 
from cftPGInvTran 
Where acct IN ('PIG TRANSFER IN', 'PIG PURCHASE') AND Reversal<>'1' AND PigGroupID=@parm1


 