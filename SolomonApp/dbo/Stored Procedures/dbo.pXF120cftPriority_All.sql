----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPriority_All 
	AS 
    	SELECT * 
	FROM cftPriority 
	ORDER BY Priority

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftPriority_All] TO [MSDSL]
    AS [dbo];

