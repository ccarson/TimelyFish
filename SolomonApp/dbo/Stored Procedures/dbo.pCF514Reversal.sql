--*************************************************************
--	Purpose: 
--	Author: Sue Matter
--	Date: 1/25/2005
--	Usage: List all unreleased batchs for a group
--	Parms: @parm1 (Pig Group ID), @parm2 (Source Line Number)
--	       
--*************************************************************

CREATE     Proc pCF514Reversal
         @parm1 varchar (10), @parm2 As Integer
as
	
Select  *
From cftPGInvTran 
Where BatNbr = @parm1 AND SourceLineNbr = @parm2 AND Reversal <> '1'



 