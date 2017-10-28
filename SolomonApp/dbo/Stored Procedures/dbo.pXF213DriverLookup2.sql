CREATE   Procedure pXF213DriverLookup2
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
From cftFeedTrDrCab tr
--From cftContact c 
--cftFeedTrDrCab tr on c.ContactID=tr.DriverID
Where tr.DriverID LIKE @parmDriver


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213DriverLookup2] TO [MSDSL]
    AS [dbo];

