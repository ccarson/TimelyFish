
----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
-- 20130311   added nolock hint
----------------------------------------------------------------------------------------
CREATE PROCEDURE [dbo].[pXF120cftOrderType_OT] 
	@parm1 varchar (2) 
	AS 
    	SELECT * 
	FROM cftOrderType (nolock)
	WHERE OrdType = @parm1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftOrderType_OT] TO [MSDSL]
    AS [dbo];

