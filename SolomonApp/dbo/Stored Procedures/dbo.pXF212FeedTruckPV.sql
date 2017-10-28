--*************************************************************
--	Purpose:Look up Trucks
--	Author: Sue Matter
--	Date: 10/30/2006
--	Usage: Feed Truck Maintenance 
--	Parms: TruckID, Location
--*************************************************************
CREATE    Procedure pXF212FeedTruckPV
	 @parmLocation As varchar(30),
	 @parmTruckID As varchar(6)

AS
Select *
From cftFeedTruck
Where Location = @parmLocation AND TruckID LIKE @parmTruckID


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXF212FeedTruckPV] TO [MSDSL]
    AS [dbo];

