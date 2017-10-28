--*************************************************************
--	Purpose:Look up Feed Cab by Location
--	Author: Sue Matter
--	Date: 10/30/2006
--	Usage: Feed Truck Maintenance 
--	Parms: Location, Cab
--*************************************************************
CREATE   Procedure pXF214FeedCab
	 @Location As varchar(30),
	 @parmCabID As varchar(10)
AS
Select c.*, v.*
From cftFeedCab c
LEFT JOIN Vendor v ON c.VENDORID=v.VENDID
Where c.Location=@Location AND
c.CabId LIKE @parmCabID
