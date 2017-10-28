----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
--		
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPigGroupRoom_PGRoom 
	@parm1 varchar (10), 
	@parm2 varchar (10) 
	AS 
    	SELECT * 
	FROM cftPigGroupRoom 
	WHERE PigGroupId = @parm1 
	AND RoomNbr = @parm2
	ORDER BY PigGroupId, RoomNbr

 