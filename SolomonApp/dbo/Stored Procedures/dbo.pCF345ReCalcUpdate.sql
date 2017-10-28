
/****** Object:  Stored Procedure dbo.pCF345ReCalcUpdate    Script Date: 11/16/2005 7:45:05 AM ******/


CREATE       PROC [dbo].[pCF345ReCalcUpdate] 


AS
	--*************************************************************
	--	Purpose: Selects recalc orders
	--	Author: Sue Matter
	--	Date: 11/11/2005
	--	Usage: Feed Order Reports app 
	--	Parms:
	--*************************************************************

Select fo.*
from cftFeedOrder fo 
JOIN cftOrderType ot on fo.OrdType=ot.OrdType and ot.User6<>1
JOIN cftPigGroup pg ON fo.PigGroupID=pg.PigGroupID
where fo.status not in ('C','X') and fo.PrtFlg=0 AND fo.CF07=1 AND pg.PigProdPhaseID='FIN'





GO
GRANT CONTROL
    ON OBJECT::[dbo].[pCF345ReCalcUpdate] TO [MSDSL]
    AS [dbo];

