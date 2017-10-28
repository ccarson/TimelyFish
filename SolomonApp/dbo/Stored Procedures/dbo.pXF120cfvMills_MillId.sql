----------------------------------------------------------------------------------------
--	Purpose: Select the mill to retrieve mill related info from cfvMills
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: @MillContactID
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cfvMills_MillId 
	@MillContactID varchar (6) 
	AS 
    	SELECT * 
	FROM cfvMills 
	WHERE MillId LIKE @MillContactID
	ORDER BY MillId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cfvMills_MillId] TO [MSDSL]
    AS [dbo];

