----------------------------------------------------------------------------------------
-- 	Purpose: Reset CF09 for Deleted Load
--	Author: Sue Matter
--	Date: 8/22/2006
--	Program Usage: XF120
--	Parms: Load Number
----------------------------------------------------------------------------------------
CREATE PROCEDURE pXF120ResetLoad
	@LoadNumber as varchar(20)
	AS
	update cftFeedOrder Set CF09='0' Where OrdNbr IN (SELECT OrdNbr 
	from cftFeedLoad Where LoadNbr=@LoadNumber)

GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF120ResetLoad] TO [MSDSL]
    AS [dbo];

