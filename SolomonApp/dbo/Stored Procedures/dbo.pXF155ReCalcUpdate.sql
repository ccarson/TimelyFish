
/****** Object:  Stored Procedure dbo.[pXF155ReCalcUpdate]    Script Date: 11/14/2005 9:57:02 AM ******/



Create PROC [dbo].[pXF155ReCalcUpdate] 
	(@FeedPlanID varchar(10))

AS
	--*************************************************************
	--	Purpose: Flags order for recalculation
	--	Author: Doran Dahle
	--	Date: 09/29/2014
	--	Usage: Standard Feed Plan entry 
	--	Parms:@FeedPlanID
	--*************************************************************

Select fo.*
from cftFeedOrder fo 
JOIN cftOrderType ot on fo.OrdType=ot.OrdType and ot.User6<>1
where fo.FeedPlanId=@FeedPlanID and fo.status not in ('C','X') and fo.PrtFlg=0


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF155ReCalcUpdate] TO [MSDSL]
    AS [dbo];

