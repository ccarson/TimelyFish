

--*************************************************************
--	Purpose:Get Group Start Date		
--	Author: Sue Matter
--	Date: 12/22/2005
--	Usage: PigTransportRecord 
--	Parms: @parm1 (PigGroupID)
--	      
--*************************************************************

CREATE  PROCEDURE pXP135GroupStart
	@parm1 as varchar(10)
	
AS
Select min(TranDate)
  From cftPGInvTran WITH (NOLOCK) 
  Where PigGroupID=@parm1
	AND Reversal<>'1' 
	AND (acct In('PIG TRANSFER IN','PIG PURCHASE') 
	OR (acct In('PIG MOVE IN','PIG MOVE OUT') 
	AND trandate<=DateAdd(day,7,(select Min(TranDate) from cftPGInvTran Where PigGroupID=@parm1 AND Reversal<>'1' AND acct In('PIG TRANSFER IN','PIG MOVE IN','PIG PURCHASE')))))	



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135GroupStart] TO [MSDSL]
    AS [dbo];

