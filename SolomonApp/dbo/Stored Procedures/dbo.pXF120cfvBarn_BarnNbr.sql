----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cfvBarn_BarnNbr 
	@parm1 varchar (10), 
	@parm2 varchar (10) 
	AS 
    	SELECT * 
	FROM cfvBarn 
	WHERE ContactId = @parm1 
	AND BarnNbr LIKE @parm2
	ORDER BY BarnNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cfvBarn_BarnNbr] TO [MSDSL]
    AS [dbo];

