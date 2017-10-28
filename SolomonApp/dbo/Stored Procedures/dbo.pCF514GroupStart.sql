--*************************************************************
--	Purpose: Find Pig Group Start date
--	Author: Sue Matter
--	Date: 8/19/2004
--	Usage: Batch Release
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


CREATE   Proc pCF514GroupStart
         @parm1 varchar (10)
as
	
Select  PigGroupID,
	min(TranDate) 
  From  cftPGInvTran
  Where (acct='PIG TRANSFER IN' or acct='PIG MOVE IN' or acct='PIG PURCHASE') 
	AND IndWgt>0 AND TotalWgt>0 AND PigGroupID=@parm1
  Group by PigGroupID


 