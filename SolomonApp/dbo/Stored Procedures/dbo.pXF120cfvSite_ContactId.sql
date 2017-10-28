

----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF120cfvSite_ContactId] 
	@parm1 varchar (6) 
	AS 
    	SELECT * 
	FROM cfvActiveSite 
	WHERE ContactId LIKE @parm1
	ORDER BY ContactId



GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cfvSite_ContactId] TO [MSDSL]
    AS [dbo];

