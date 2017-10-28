
--*************************************************************
--	Purpose:Get Released Qty for specified PigGroupID for a point in time		
--	Author: Charity Anderson
--	Date: 5/12/2004
--	Usage: Tranportation Module 
--	Parms: @parm1 (PigGroupID), Reference Date
--	       
--*************************************************************

CREATE PROC dbo.pXT100PigGroupReleasedPIT 
		@parm1 as varchar(10), @RefDate as smalldatetime
AS
Select SourcePigGroupID as PigGroupID,  isnull(Sum(EstimatedQty),0) as AssignedQty 
	from cftPM WITH (NOLOCK) 
	where SourcePigGroupID=@parm1 
	and MovementDate<=@RefDate
	and (Highlight <> 255 and Highlight <> -65536)
	Group by SourcePigGroupID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PigGroupReleasedPIT] TO [MSDSL]
    AS [dbo];

