--Created by: Charity Gaborik
--Created Date: 12/1/2002
--Queries sites for a specific Service Manager by passing in the UserID
--The defined ServiceManager is at the barn level
--Procedure also accounts for listing all sites associated with Service Managers assigned 
--to a specific Marketing Specialist
--Used in Marketing App as the recordsource for the SourceSite dropdown
CREATE PROCEDURE [dbo].[pFindSites] 
	@ServiceManager varchar(20),
	@EndDate smalldatetime,
	@StartDate smalldatetime='1/1/1901'
AS 

SELECT DISTINCT s.ContactID, s.ContactName as DescriptiveName, dbo.GetSvcManager(s.ContactID,@EndDate, @StartDate) as UserID
FROM         dbo.vSitewithContactName s 
WHERE s.StatusTypeID=1 and (dbo.GetSvcManager(s.ContactID,@EndDate, @StartDate)=@ServiceManager
					 or dbo.GetMarketSvcManager(s.ContactID,@EndDate, @StartDate)=@ServiceManager)
			
UNION Select Null, '',''

Order by DescriptiveName
