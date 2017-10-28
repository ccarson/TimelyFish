----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPGStatus_Status 
	@parm1 varchar (2) 
	AS 
    	SELECT * 
	FROM cftPGStatus 
	WHERE PGStatusId = @parm1

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftPGStatus_Status] TO [MSDSL]
    AS [dbo];

