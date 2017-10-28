
--*************************************************************
--	Purpose: Summarize all deads
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: PreMarker Summary
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************




CREATE   Proc dbo.pXP101Deads
		@parm1 As Varchar(10)

as
select PigGroupID, TranDate, Sum(Qty) As Total
	FROM cftPGInvTran
	WHERE Reversal<>'1' AND acct='PIG DEATH' AND PigGroupId=@parm1
        Group by PigGroupID, TranDate


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP101Deads] TO [MSDSL]
    AS [dbo];

