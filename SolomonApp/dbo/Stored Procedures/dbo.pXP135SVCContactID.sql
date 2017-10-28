
--*************************************************************
--	Purpose:Look up SVC ContactID
--	Author: Doran Dahle
--	Date: 4/25/2012
--	Usage: PigTransportRecord app 
--	Parms:SiteContactID ,EndDate,StartDate
--*************************************************************

CREATE PROC [dbo].[pXP135SVCContactID]
	@SiteContactID as int, @EndDate as smalldatetime,@StartDate as smalldatetime
AS
Select ContactID as SVCContactID from cftContact where ContactID=dbo.GetSVCManagerID(@SiteContactID,@EndDate,@StartDate)


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP135SVCContactID] TO [MSDSL]
    AS [dbo];

