----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPigGroup_PigGroup 
	@parm1 varchar (10), 
	@parm2 varchar (10) 
	AS 
    	SELECT p.* 
	FROM cftPigGroup p 
	LEFT JOIN cftPigGroupRoom r ON p.PigGroupId = r.PigGroupId 
	WHERE p.PigGroupId = @parm1 
	AND (RoomNbr = @parm2 OR RoomNbr Is Null)
	AND EXISTS (SELECT * FROM cftPGStatus WHERE p.PGStatusId = PGStatusId AND
			Status_PA = 'A' AND Status_IN = 'A')
	ORDER BY p.PigGroupId

 