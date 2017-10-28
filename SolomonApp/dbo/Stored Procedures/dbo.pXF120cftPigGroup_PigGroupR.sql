----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPigGroup_PigGroupR 
	@parm1 varchar (10), 
	@parm2 varchar (10) 
	AS 
    	SELECT p.* 
	FROM cftPigGroup p 
	LEFT JOIN cftPigGroupRoom r ON p.PigGroupId = r.PigGroupId 
	WHERE p.PigGroupId = @parm1 
	AND (RoomNbr = @parm2 OR RoomNbr Is Null)
	ORDER BY p.PigGroupId

 