--*************************************************************
--	Purpose:Get Assigned Qty for specified PigGroupID		
--	Author: Charity Anderson
--	Date: 3/15/2004
--	Usage: Tranportation Module 
--	Parms: @parm1 (PigGroupID)
--	       
--*************************************************************

CREATE PROC dbo.pCF100PigGroupAssigned 
		@parm1 as varchar(10)
AS
Select PigGroupID, Sum(Qty) as AssignedQty from vCF100PigGroupQty 
	where PigGroupID=@parm1
	Group by PigGroupID

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF100PigGroupAssigned] TO [MSDSL]
    AS [dbo];

