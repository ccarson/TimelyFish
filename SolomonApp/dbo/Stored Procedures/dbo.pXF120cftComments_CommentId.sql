----------------------------------------------------------------------------------------
--	Purpose: 
--	Author: Timothy Jones
--	Date: 9/1/2005
--	Program Usage: XF120
--	Parms: 
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120cftComments_CommentId 
	@parm1 varchar (5) 
	AS 
    	SELECT * 
	FROM cftComments 
	WHERE CommentId LIKE @parm1
	ORDER BY CommentId

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120cftComments_CommentId] TO [MSDSL]
    AS [dbo];

