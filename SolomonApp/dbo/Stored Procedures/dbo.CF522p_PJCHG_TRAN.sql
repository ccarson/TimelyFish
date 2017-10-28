--*************************************************************
--	Purpose: Find unallocated transfers
--	Author: Sue Matter
--	Date: 1/19/2005
--	Usage: Pig Group Close
--	Parms: @parm1 (Pig Group ID)
--	       
--*************************************************************


Create Procedure dbo.CF522p_PJCHG_TRAN @parm1 varchar (16) as
 	Select * from cftPGInvTran where PC_Stat=0 AND PigGroupID= @parm1 
	Order by PigGroupID, acct, TranDate


 
GO
GRANT CONTROL
    ON OBJECT::[dbo].[CF522p_PJCHG_TRAN] TO [MSDSL]
    AS [dbo];

