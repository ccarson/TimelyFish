CREATE   Procedure pXF213DriverLookup
	@parmDriver As varchar(6)--, @parmdate smalldatetime--, 	@parmload As Char(6)

----------------------------------------------------------------------------------------
--	Purpose: Driver PV
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @parmSite site id
----------------------------------------------------------------------------------------

AS
Select tr.* 
From cftFeedDriver tr
--From cftContact c 
--JOIN cftFeedTrDrCab tr on c.ContactID=tr.DriverID
Where tr.ContactID LIKE @parmDriver


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213DriverLookup] TO [MSDSL]
    AS [dbo];

