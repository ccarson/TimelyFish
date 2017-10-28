


--*************************   Post Ship query
CREATE VIEW [dbo].[cfv_HAT_VET_Schedule_PMLoads]
AS
SELECT [MovementDate]
	  ,	s.ScheduleID
	  ,SC.[ContactName] as SourceName
      ,[SourceState]
      ,DC.[ContactName] as DestName
      ,[DestState]
      ,[ID]
      
  FROM [SolomonApp].[dbo].[cfv_HAT_VET_PMLoads] pm (nolock) 
  join [SolomonApp].[dbo].[cftContact] DC  (nolock) on PM.[DestContactID] = DC.ContactID
  join [SolomonApp].[dbo].[cftContact] SC  (nolock) on  PM.[SourceContactID] = SC.ContactID 
  join [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] s  (nolock) on pm.SourceContactID = s.SiteContactID and pm.MovementDate between s.TargetDate and s.ExpireDate
  where pm.[PigTypeID] NOT IN ('04','05','08','10','11') 
  
 UNION 

  SELECT [MovementDate]
	  ,	s.ScheduleID
	  ,SC.[ContactName] as SourceName
      ,[SourceState]
      ,DC.[ContactName] as DestName
      ,[DestState]
      ,[ID]
      
  FROM [SolomonApp].[dbo].[cfv_HAT_VET_PMLoads] pm (nolock) 
  join [SolomonApp].[dbo].[cftContact] DC  (nolock) on PM.[DestContactID] = DC.ContactID
  join [SolomonApp].[dbo].[cftContact] SC  (nolock) on PM.[SourceContactID] = SC.ContactID 
  join [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] s  (nolock) on pm.SourceContactID = s.SiteContactID and pm.MovementDate between s.TargetDate and s.ExpireDate
   where pm.[PigTypeID] = '04' and PM.MarketSaleTypeID = '60'

UNION 

  SELECT [MovementDate]
	  ,	s.ScheduleID
	  ,SC.[ContactName] as SourceName
      ,[SourceState]
      ,DC.[ContactName] as DestName
      ,[DestState]
      ,[ID]
      
  FROM [SolomonApp].[dbo].[cfv_HAT_VET_PMLoads] pm (nolock) 
  join [SolomonApp].[dbo].[cftContact] DC  (nolock) on PM.[DestContactID] = DC.ContactID
  join [SolomonApp].[dbo].[cftContact] SC  (nolock) on PM.[SourceContactID] = SC.ContactID 
  join [SolomonApp].[dbo].[cft_HAT_Vet_Schedule] s  (nolock) on pm.SourceContactID = s.SiteContactID and pm.MovementDate between s.TargetDate and s.ExpireDate
   where pm.[PigTypeID] = '08' and PM.TranSubTypeID NOT LIKE '%M%'


