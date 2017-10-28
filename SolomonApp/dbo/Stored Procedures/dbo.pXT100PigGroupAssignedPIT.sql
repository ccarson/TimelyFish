
--*************************************************************
--	Purpose:Get Point in Time Assigned Qty for specified PigGroupID
--		 based on a reference date	
--	Author: Charity Anderson
--	Date: 3/15/2004
--	Usage: Tranportation Module 
--	Parms: @parm1 (PigGroupID, RefDate)
--	       
--*************************************************************

CREATE PROC dbo.pXT100PigGroupAssignedPIT 
		@parm1 as varchar(10),@RefDate as smalldateTime
AS
Select DestPigGroupID as PigGroupID, isnull(Sum(EstimatedQty),0) as AssignedQty 
	from cftPM  WITH (NOLOCK) 
	where DestPigGroupID=@parm1
	and MovementDate<=@RefDate
	and (Highlight <> 255 and Highlight <> -65536)

	Group by DestPigGroupID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PigGroupAssignedPIT] TO [MSDSL]
    AS [dbo];

