
--*************************************************************
--	Purpose:Get Assigned Qty for specified PigGroupID		
--	Author: Charity Anderson
--	Date: 3/15/2004
--	Usage: Tranportation Module 
--	Parms: @parm1 (PigGroupID)
--	       
--*************************************************************

CREATE PROC dbo.pXT100PigGroupAssigned 
		@parm1 as varchar(10)
AS


Select DestPigGroupID as PigGroupID,  isnull(Sum(EstimatedQty),0) as AssignedQty 
	from cftPM WITH (NOLOCK) 
	where DestPigGroupID=@parm1 
	and (Highlight <> 255 and Highlight <> -65536)
	Group by DestPigGroupID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PigGroupAssigned] TO [MSDSL]
    AS [dbo];

