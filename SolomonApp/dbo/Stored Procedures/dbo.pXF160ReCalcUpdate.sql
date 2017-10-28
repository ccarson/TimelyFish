


CREATE   PROC [dbo].[pXF160ReCalcUpdate] 
	(@parm1 varchar(10), @parm2 varchar(10))

AS
	--*************************************************************
	--	Purpose:Retreive Feed Orders
	--	Author: Sue Matter
	--	Date: 11/11/2005
	--	Usage: Individual Feed Plan app 
	--	Parms:PigGroupID, RoomNbr
	--*************************************************************
	/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2014-10-09  Doran Dahle Changed to include WTF and exclude Flush Orders (FL).
2016-01-09  Doran Dahle Changed to include HIN.

===============================================================================
*/

Select fo.*
from cftFeedOrder fo 
JOIN cftOrderType ot on fo.OrdType=ot.OrdType and ot.User6<>1
JOIN cftPigGroup pg ON fo.PigGroupID=pg.PigGroupID
where fo.PigGroupID=@parm1 and fo.RoomNbr=@parm2 AND pg.PigProdPhaseID IN ('FIN','WTF','HIN')
and fo.status not in ('C','X') and fo.PrtFlg=0 and fo.OrdType not like 'FL'






GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF160ReCalcUpdate] TO [MSDSL]
    AS [dbo];

