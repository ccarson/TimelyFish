----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftFeedOrder_SrcOrdNbr 
	@parm1 varchar (10) 
	AS 
    	SELECT * 
	FROM cftFeedOrder 
	JOIN cftContact ON cftFeedOrder.ContactID=cftContact.ContactID 
	WHERE DateReq>=GetDate()-30 
	AND OrdNbr LIKE @parm1 
	ORDER BY OrdNbr

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftFeedOrder_SrcOrdNbr] TO [MSDSL]
    AS [dbo];

