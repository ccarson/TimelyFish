----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120CFAutoOrdNbr 
	AS 
    	SELECT LastOrdNbr 
	FROM cftFOSetUp

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120CFAutoOrdNbr] TO [MSDSL]
    AS [dbo];

