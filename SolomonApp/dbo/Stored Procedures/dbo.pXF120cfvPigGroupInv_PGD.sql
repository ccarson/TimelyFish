----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cfvPigGroupInv_PGD 
	@parm1 varchar (10), 
	@parm2 smalldatetime 
	AS 
    	SELECT Sum(Qty) 
	FROM cfvPigGroupInv 
	WHERE PigGroupId = @parm1 
	AND TranDate <= @parm2

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cfvPigGroupInv_PGD] TO [MSDSL]
    AS [dbo];

