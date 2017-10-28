
/****** Object:  Stored Procedure dbo.pCF511ReCalcUpdate    Script Date: 11/14/2005 9:57:02 AM ******/



CREATE     PROC pCF511ReCalcUpdate 
	(@parm1 varchar(10))

AS
	--*************************************************************
	--	Purpose: Selects future orders
	--	Author: Sue Matter
	--	Date: 11/11/2005
	--	Usage: Feed Order app 
	--	Parms:PigGroupID, RoomNbr, Order Number, Scheduled Date
	--*************************************************************

Select fo.*
from cftFeedOrder fo 
JOIN cftOrderType ot on fo.OrdType=ot.OrdType and ot.User6<>1
where fo.PigGroupID=@parm1 and fo.status not in ('C','X') and fo.PrtFlg=0





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF511ReCalcUpdate] TO [MSDSL]
    AS [dbo];

