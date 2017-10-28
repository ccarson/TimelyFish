
----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: None
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF120cftOrderType_All] 
	AS 
    	SELECT * 
	FROM cftOrderType (nolock)
	ORDER BY OrdType


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftOrderType_All] TO [MSDSL]
    AS [dbo];

