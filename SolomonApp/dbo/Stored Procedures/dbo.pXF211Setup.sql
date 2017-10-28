CREATE Procedure pXF211Setup
----------------------------------------------------------------------------------------
--	Purpose: Select last load number
--	Author: Sue Matter
--	Date: 8/1/2006
--	Program Usage: XF211
--	Parms: 
----------------------------------------------------------------------------------------
AS
Select * 
FROM cftFeedLoadSetup


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF211Setup] TO [MSDSL]
    AS [dbo];

