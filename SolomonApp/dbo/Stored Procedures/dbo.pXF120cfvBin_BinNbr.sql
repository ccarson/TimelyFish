----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
/*
===============================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------
2012-02-15  Doran Dahle Added the active bin clause
						

===============================================================================
*/
CREATE PROCEDURE [dbo].[pXF120cfvBin_BinNbr] 

	@parm1 varchar (6), 
	@parm2 varchar (6) 
	AS 
    	SELECT * 
	FROM cfvBin 
	WHERE ContactId = @parm1 
	AND BinNbr LIKE @parm2
	AND Active <> 0
	ORDER BY ContactId, BinNbr	

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cfvBin_BinNbr] TO [MSDSL]
    AS [dbo];

