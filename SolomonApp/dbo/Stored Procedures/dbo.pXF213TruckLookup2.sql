
CREATE   Procedure pXF213TruckLookup2
	@parmTruck As varchar(5)

----------------------------------------------------------------------------------------
--	Purpose: Truck PV
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @parmTruck
----------------------------------------------------------------------------------------

AS
SELECT	*
FROM 		dbo.cftFeedTrDrCab (NOLOCK)
WHERE		TruckID LIKE @parmTruck
ORDER BY 	EffectiveDate DESC


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213TruckLookup2] TO [MSDSL]
    AS [dbo];

