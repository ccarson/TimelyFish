----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftSubstMill_IM 
	@parm1 varchar (30), 
	@parm2 varchar (6) 
	AS 
    	SELECT * 
	FROM cftSubstMill 
	WHERE InvtId = @parm1 
	AND MillIdDflt LIKE @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftSubstMill_IM] TO [MSDSL]
    AS [dbo];

