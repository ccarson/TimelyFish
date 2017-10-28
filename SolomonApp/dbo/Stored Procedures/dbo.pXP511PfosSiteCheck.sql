--*************************************************************
--	Purpose:Check for Pfos Site record
--	Author: Doran Dahle
--	Date: 10/04/2012
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
CREATE  PROC [dbo].[pXP511PfosSiteCheck]
	@SiteID as int
	WITH EXECUTE AS '07718158D19D4f5f9D23B55DBF5DF1'
AS
Select count(ps.[ContactID]) AS cnt 
from [CentralData].[dbo].[cftPfosSite] ps
where ps.ContactID=@SiteID AND ps.Eff_dateTime <= GetDate() AND (ps.Expire_dateTime IS NULL or ps.Expire_dateTime > GetDate())
