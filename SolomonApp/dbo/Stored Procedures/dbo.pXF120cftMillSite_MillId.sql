
----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF120cftMillSite_MillId] 
	@parm1 varchar (6) 
	AS 
    	SELECT * 
	FROM cftMillSite (nolock)
	WHERE MillId = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftMillSite_MillId] TO [MSDSL]
    AS [dbo];

