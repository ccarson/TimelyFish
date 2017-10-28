CREATE   Procedure pXF213TruckLookup
	@parmTruck As varchar(6)--, @parmdate smalldatetime--, @parm3 As Char(6)

----------------------------------------------------------------------------------------
--	Purpose: Truck PV
--	Author: Sue Matter
--	Date: 7/20/2006
--	Program Usage: XF213
--	Parms: @parmTruck truck id
----------------------------------------------------------------------------------------


AS
Select * 
From cftFeedTruck
Where TruckID LIKE @parmTruck AND Active=1


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF213TruckLookup] TO [MSDSL]
    AS [dbo];

