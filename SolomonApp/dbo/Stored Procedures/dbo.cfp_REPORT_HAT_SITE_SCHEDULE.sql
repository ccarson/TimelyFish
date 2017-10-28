



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_HAT_SITE_SCHEDULE] 
	@StartDate datetime,
	@EndDate datetime,
	@Site	varchar(1000)
	
AS
BEGIN
	set @StartDate = DATEADD (day,-4,@StartDate)  --Back the date up 4 days to get all of the pre test movements in the given date range.
	set @EndDate = DATEADD (day,2,@EndDate)  --push out the end date 2 days to get all the post test of the movements in the given date range.

    IF CHARINDEX('%', @Site) > 0 
   	     Select [ScheduleID]
      ,[TestDate]
      ,[SiteContactID]
      ,[SiteName]
      ,[TestComment]
      ,[SPID]
      ,[Protocol_Type]
      ,[Name]
      ,[TestSite]
      ,[TestSiteID]
      ,[Type]
      ,[SampleQty]
      ,[Comment]
      ,[Frequency] 
      ,[Lab]
      ,[Status]
      from [dbo].[cfv_HAT_Site_Schedule]
	     Where [TestDate] between @StartDate and @EndDate 
	   order by [SiteName] asc, [TestDate]
    ELSE
       Select [ScheduleID]
      ,[TestDate]
      ,[SiteContactID]
      ,[SiteName]
      ,[TestComment]
      ,[SPID]
      ,[Protocol_Type]
      ,[Name]
      ,[TestSite]
      ,[TestSiteID]
      ,[Type]
      ,[SampleQty]
      ,[Comment]
      ,[Frequency] 
      ,[Lab]
      ,[Status]
      from [dbo].[cfv_HAT_Site_Schedule]
	      Where SiteContactID in (select * from SolomonApp.dbo.cffn_SPLIT_STRING( @Site, ',')) 
	      And [TestDate] between @StartDate and @EndDate 
	   order by [SiteName] asc, [TestDate]
END




