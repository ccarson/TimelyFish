--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPigGroup_CBRCnt 
	@parm1 varchar (10), 
	@parm2 varchar (6), 
	@parm3 varchar (10) 
	AS 
    	SELECT Count(*) 
	FROM cftPigGroup p 
	LEFT JOIN cftPigGroupRoom r ON p.PigGroupId = r.PigGroupId 
	WHERE SiteContactId = @parm1 
	AND BarnNbr = @parm2 
	AND (RoomNbr = @parm3 OR RoomNbr Is Null)
	AND EXISTS (SELECT * FROM cftPGStatus WHERE p.PGStatusId = PGStatusId AND
			Status_PA = 'A' AND Status_IN = 'A')

 