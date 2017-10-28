





CREATE VIEW [dbo].[cfv_HAT_Site_PM]
AS
-- PRE Query
Select HAT.[ScheduleID]
      ,d.ContactID as DestContactID
      ,d.ContactName as Destination
      ,[DestPigGroupID]
      ,[DestBarnNbr]
      ,[DestRoomNbr]
      ,[Highlight]
      ,[ID]
      ,[MovementDate]
      ,PT.[PigTypeDesc]
      ,[PMID]
      ,[PMLoadID]
      ,s.ContactID as SourceContactID
      ,s.ContactName as Source
      ,[SourceBarnNbr]
      ,[SourcePigGroupID]
      ,[SourceRoomNbr]
      ,[TattooFlag]
      

from cftPM pm 
inner JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
inner JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
inner Join [SolomonApp].[dbo].[cfv_HAT_PMSchedule] HTP on PM.SourceContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
inner Join [SolomonApp].[dbo].[cft_HAT_Schedule] HAT on PM.SourceContactID = HAT.[SiteContactID] and HTP.SPID = HAT.SPID
inner Join [SolomonApp].[dbo].[cfv_HAT_HTP_Schedule] SCH on PM.SourceContactID = SCH.[siteID] and HTP.SPID = SCH.SPID
left Join [SolomonApp].[dbo].[cftPigType] pt on pm.PigTypeID = pt.PigTypeID
where pm.MovementDate between HAT.[TestDate] AND HAT.[ExpireDate] 

and PMTypeID='01'
AND TranSubTypeID is not null
AND HTP.[Timing] like 'Pre'

union

Select HAT.[ScheduleID]
      ,d.ContactID as DestContactID
      ,d.ContactName as Destination
      ,[DestPigGroupID]
      ,[DestBarnNbr]
      ,[DestRoomNbr]
      ,[Highlight]
      ,[ID]
      ,[MovementDate]
      ,PT.[PigTypeDesc]
      ,[PMID]
      ,[PMLoadID]
      ,s.ContactID as SourceContactID
      ,s.ContactName as Source
      ,[SourceBarnNbr]
      ,[SourcePigGroupID]
      ,[SourceRoomNbr]
      ,[TattooFlag]

from cftPM pm 
inner JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
inner JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
inner Join [dbo].[cfv_HAT_PMSchedule] HTP on PM.DestContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
inner Join [SolomonApp].[dbo].[cft_HAT_Schedule] HAT on pm.DestContactID = HAT.[SiteContactID] and HTP.SPID = HAT.SPID
left Join [SolomonApp].[dbo].[cftPigType] pt on pm.[PigTypeID] = pt.[PigTypeID]
where pm.MovementDate = HAT.[TestDate] - HTP.days 

and PMTypeID='01'
AND TranSubTypeID is not null
AND HTP.[Timing] like 'Post'









