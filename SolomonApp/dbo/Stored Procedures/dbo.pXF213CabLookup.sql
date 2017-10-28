CREATE   Procedure pXF213CabLookup
	@parmCab As varchar(5)

----------------------------------------------------------------------------------------
--	Purpose: Cab PV
--	Author: Sue Matter
--	Date: 11/10/2006
--	Program Usage: XF213
--	Parms: @parmCab
----------------------------------------------------------------------------------------

AS
Select tr.* 
From cftFeedCab tr
Where tr.CabId LIKE @parmCab


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213CabLookup] TO [MSDSL]
    AS [dbo];

