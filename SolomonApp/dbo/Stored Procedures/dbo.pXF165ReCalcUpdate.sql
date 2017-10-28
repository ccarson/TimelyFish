
/****** Object:  Stored Procedure dbo.[pXF155ReCalcUpdate]    Script Date: 11/14/2005 9:57:02 AM ******/



Create PROC [dbo].[pXF165ReCalcUpdate] 
	(@PigGroupID varchar(10),
	@RoomNbr varchar(10))

AS
	--*************************************************************
	--	Purpose: Flags order for recalculation
	--	Author: Doran Dahle
	--	Date: 09/29/2014
	--	Usage: Feed Plan Flow Maintenance 
	--	Parms:@PigGroupID , @RoomNbr
	--*************************************************************
Select fo.*
from cftFeedOrder fo 
JOIN cftOrderType ot on fo.OrdType=ot.OrdType and ot.User6<>1
where fo.PigGroupID = @PigGroupID
and fo.RoomNbr like @RoomNbr
and fo.OrdType not like 'FL'
and fo.status not in ('C','X') and fo.PrtFlg=0


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF165ReCalcUpdate] TO [MSDSL]
    AS [dbo];

