CREATE PROC pXF185FOReCalcUpdate 
	(@parm1 varchar(10), @parm2 varchar(10), @parm3 smalldatetime)

AS
	--*************************************************************
	--	Purpose:Flags future orders that need to be recalculated
	--	Author: Charity ANDerson
	--	Date: 11/9/2005
	--	Usage: Feed Delivery app 
	--	Parms:PigGroupID, RoomNbr, DeliveryDate
	--*************************************************************
Update 
cftFeedOrder  
Set CF07=1
from cftFeedOrder fo 
JOIN cftOrderType ot on fo.OrdType=ot.OrdType and ot.User6<>1
where fo.PigGroupID=@parm1 and fo.RoomNbr=@parm2 
and fo.DateSched>@parm3 and fo.status not in ('C','X') and fo.PrtFlg=0

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185FOReCalcUpdate] TO [MSDSL]
    AS [dbo];

