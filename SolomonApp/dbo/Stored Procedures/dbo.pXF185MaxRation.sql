--*************************************************************
--	Purpose: Get previous max withdrawal ration
--	Author: Sue Matter
--	Date: 3/23/2006
--	Usage: Feed Order Delivery		 
--	Parms:  
--*************************************************************

CREATE    PROCEDURE pXF185MaxRation

 AS 
 SELECT *
	FROM cftRationExc
	Where WithdrawalDays=(Select Max(WithdrawalDays) from cftRationExc)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF185MaxRation] TO [MSDSL]
    AS [dbo];

