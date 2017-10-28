
--*************************************************************
--	Purpose:Check for Flow Site record
--	Author: Doran Dahle
--	Date: 6/04/2014
--	Usage: Pig Group Maintenance			 
--	Parms: SiteContactID
--*************************************************************
/*
================================================================================
Change Log:
Date        Who           Change
----------- ----------- -------------------------------------------------------

===============================================================================
*/
CREATE  PROC [dbo].[pXP511flowSiteCheck]
	@SiteID as int
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
Select count(ps.[ContactID]) AS cnt 
from [CentralData].[dbo].[cftFeedFlowSite] ps
where ps.ContactID=@SiteID AND ps.Disabled_dateTime <= GetDate() AND (ps.ReEnabled_dateTime IS NULL or ps.ReEnabled_dateTime > GetDate())


GO
GRANT CONTROL
    ON OBJECT::[dbo].[pXP511flowSiteCheck] TO [MSDSL]
    AS [dbo];

