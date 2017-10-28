--*************************************************************
--	Purpose:Look up Feed Trucks by Location
--	Author: Sue Matter
--	Date: 10/30/2006
--	Usage: Feed Truck Maintenance 
--	Parms: Location
--*************************************************************

CREATE    Procedure pXF212FeedTruck
	@parm1 varchar (30),
	@parmTruckID As varchar(6)
AS
Select *
From cftFeedTruck
Where Location = @parm1 
AND TruckID LIKE @parmTruckID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF212FeedTruck] TO [MSDSL]
    AS [dbo];

