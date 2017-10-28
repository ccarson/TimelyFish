
--**************************************************************************************
--	Purpose:Find existing master groups at a site within 14 days of the est close date
--	Author: Nick Honetschlager
--	Date: 11/03/2014
--	Usage: Master Group Maintenance	 
--	Parms: EstCloseDate, SiteContactID, PigProdPodID
--**************************************************************************************

CREATE PROC [dbo].[pCF215ExistingMasterGroups]
	(@estCloseDate as smalldatetime, @siteContactID as varchar(10), @pigProdPodID as varchar(2) )
AS

SELECT *
FROM cftPigGroup
WHERE SiteContactID = @siteContactID
AND PigProdPodID = @pigProdPodID
AND ABS(DATEDIFF(DD, @estCloseDate, EstCloseDate)) <= 14
AND CF03 <> ''

