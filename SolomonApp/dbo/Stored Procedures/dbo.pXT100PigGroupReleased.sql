
--*************************************************************
--	Purpose:Get Released Qty for specified PigGroupID		
--	Author: Charity Anderson
--	Date: 5/12/2004
--	Usage: Tranportation Module 
--	Parms: @parm1 (PigGroupID)
--	       
--*************************************************************

CREATE PROC dbo.pXT100PigGroupReleased 
		@parm1 as varchar(10)
AS
Select SourcePigGroupID as PigGroupID,  isnull(Sum(EstimatedQty),0) as AssignedQty 
	from cftPM WITH (NOLOCK) 
	where SourcePigGroupID=@parm1
	and (Highlight <> 255 and Highlight <> -65536)
	Group by SourcePigGroupID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXT100PigGroupReleased] TO [MSDSL]
    AS [dbo];

