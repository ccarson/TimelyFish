----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120PJPent_ProjTask 
	@parm1 varchar (16), 
	@parm2 varchar (32) 
	AS 
    	SELECT * 
	FROM PJPent 
	WHERE Project = @parm1 
	AND Pjt_Entity = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120PJPent_ProjTask] TO [MSDSL]
    AS [dbo];

