----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Doran Dahle
--	Date: 3/2/2012
--	Program Usage: XF503
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF305cftOrderStatus] 
	AS 
    	SELECT * 
	FROM cftOrderStatus 
	where [status] in ('H','M','O','P','R','S','T','V','E','F','G')
   

	ORDER BY Status
GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF305cftOrderStatus] TO [MSDSL]
    AS [dbo];

