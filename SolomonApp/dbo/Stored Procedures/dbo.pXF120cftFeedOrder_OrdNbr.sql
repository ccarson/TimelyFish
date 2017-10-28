----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedOrder_OrdNbr 
	@parm1 varchar (10) 
	AS 
    	SELECT * 
	FROM cftFeedOrder 
	WHERE OrdNbr LIKE @parm1
	ORDER BY OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedOrder_OrdNbr] TO [MSDSL]
    AS [dbo];

