
--*************************************************************
--	Purpose:Look up Feed Cab and Driver Assignment by Location
--	Author: Sue Matter
--	Date: 10/30/2006
--	Usage: Feed Truck Maintenance 
--	Parms: Location, DrTrCabID
--*************************************************************
CREATE     Procedure pXF212FeedCabTr
	 @Location As varchar(30), @parmCabID As varchar(10)
AS
Select *
From cftFeedTrDrCab asn
JOIN cftFeedCab cb ON asn.CabID=cb.CabID 
JOIN cftFeedTruck tr ON asn.TruckID=tr.TruckID
JOIN cftFeedDriver dr ON asn.DriverID=dr.ContactID
JOIN cftContact ct ON dr.ContactID=ct.ContactID
Where cb.Location = @Location AND tr.Location = @Location AND dr.CF01= @Location AND asn.DrTrCabId LIKE @parmCabID



