--*************************************************************
--	Purpose:Check for reversals
--	Author: Sue Matter
--	Date: 8/19/2004
--	Usage: Pig Group Inventory Adjustment 
--	Parms: @parm1 (Batch Number), @parm2 (line number)
--	      
--*************************************************************
CREATE      Proc pCF512Reversal
         @parm1 varchar (10), @parm2 As Integer
as
	
Select  *
From cftPGInvTran 
Where BatNbr = @parm1 AND LineNbr = @parm2 AND Reversal <> '1'


 