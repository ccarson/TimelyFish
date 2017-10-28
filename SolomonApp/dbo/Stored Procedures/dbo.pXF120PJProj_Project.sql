----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120PJProj_Project 
	@parm1 varchar (16) 
	AS 
    	SELECT * 
	FROM PJProj 
	WHERE Project = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120PJProj_Project] TO [MSDSL]
    AS [dbo];

