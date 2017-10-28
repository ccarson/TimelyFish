--*************************************************************
--	Purpose:Look up Cabs
--	Author: Sue Matter
--	Date: 10/30/2006
--	Usage: Feed Truck Maintenance 
--	Parms: CabId
--*************************************************************
CREATE   Procedure pXF212FeedCabPV
	 @Location AS varchar(30), @parmCabID As varchar(10)
AS
Select c.*
From cftFeedCab c
LEFT JOIN Vendor v ON c.VENDORID=v.VENDID
Where c.Location=@Location AND
c.CabId LIKE @parmCabID
