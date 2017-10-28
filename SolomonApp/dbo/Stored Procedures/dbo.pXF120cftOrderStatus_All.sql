----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftOrderStatus_All 
	AS 
    	SELECT * 
	FROM cftOrderStatus 
	ORDER BY Status

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftOrderStatus_All] TO [MSDSL]
    AS [dbo];

