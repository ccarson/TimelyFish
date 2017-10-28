

CREATE      PROC [dbo].[pXF120ReCalcUpdate] 
	(@parm1 varchar(10), @parm2 varchar(10), @parm3 smalldatetime)

AS
	--*************************************************************
	--	Purpose: Selects future orders
	--	Author: Sue Matter
	--	Date: 11/11/2005
	--	Usage: Feed Order app 
	--	Parms:PigGroupID, RoomNbr, Order Number, Scheduled Date
	--*************************************************************
--Update 
--cftFeedOrder  
--Set CF07=1
Select fo.*
from cftFeedOrder fo (nolock)
JOIN cftOrderType ot (nolock) on fo.OrdType=ot.OrdType and ot.User6<>1
JOIN cfvBin bn  (nolock) ON    fo.ContactID=bn.ContactID AND fo.BarnNbr=bn.BarnNbr AND fo.BinNbr=bn.BinNbr AND RTrim(bn.BinTypeDesc)<>'Creep'
where fo.PigGroupID=@parm1 and fo.RoomNbr=@parm2 AND fo.DateSched>@parm3 and fo.status not in ('C','X') and fo.PrtFlg=0





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120ReCalcUpdate] TO [MSDSL]
    AS [dbo];

