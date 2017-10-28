--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftPigGroup_CBPGIdR 
	@parm1 varchar (10), 
	@parm2 varchar (6), 
	@parm3 varchar (10), 
	@parm4 varchar (10) 
	AS 
    	SELECT p.* 
	FROM cftPigGroup p 
	LEFT JOIN cftPigGroupRoom r ON p.PigGroupId = r.PigGroupId
	WHERE p.SiteContactId = @parm1 
	AND p.BarnNbr = @parm2 
	AND p.PigGroupId LIKE @parm4
	and (r.RoomNbr = @parm3 OR r.RoomNbr Is Null)
	ORDER BY p.PigGroupId

 