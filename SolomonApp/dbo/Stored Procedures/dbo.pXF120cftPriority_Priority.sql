----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPriority_Priority 
	@parm1 varchar (10) 
	AS 
	SELECT * 
	FROM cftPriority 
	WHERE Priority LIKE @parm1
	ORDER BY Priority

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftPriority_Priority] TO [MSDSL]
    AS [dbo];

