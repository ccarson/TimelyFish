




--*************************   Post Ship query
CREATE VIEW [dbo].[cfv_HAT_Conflict_PMLoads]
AS
SELECT 
	   pre.[SourceContactID] as SiteID
	  ,pre.[Source] as SiteName
	  ,post.[PMID] as Post_PMID
      ,post.[PMLoadID] as Post_PMLoadID
      ,post.[MovementDate] as Post_MovementDate
      ,post.[Days] as Post_Days
      ,post.[Source] as Received_From
      ,pre.[PMID] as Pre_PMID
      ,pre.[PMLoadID] as Pre_PMLoadID
      ,pre.[MovementDate] as Pre_MovementDate
      ,pre.[Days] as Pre_days
      ,pre.[Destination] as Ship_to
     
      
  FROM [SolomonApp].[dbo].[cfv_HAT_PreShip_PMLoads] pre
  inner join [SolomonApp].[dbo].[cfv_HAT_PostArrival_PMLoads] post on pre.[SourceContactID] = post.[DestContactID]
  where DATEADD(day,-pre.days,pre.[MovementDate]) < DATEADD(day,post.days,post.[MovementDate]) 
  and pre.[MovementDate] > post.[MovementDate]





