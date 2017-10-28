----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftRoom_RoomNbr 
	@parm1 varchar (6), 
	@parm2 varchar (10) 
	AS 
    	SELECT * 
	FROM cftRoom 
	WHERE ContactId = @parm1 
	AND RoomNbr = @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftRoom_RoomNbr] TO [MSDSL]
    AS [dbo];

