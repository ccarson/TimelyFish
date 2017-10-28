




--*************************   Post Ship query
CREATE VIEW [dbo].[cfv_HAT_PostArrival_PMLoads]
AS
Select 
       d.ContactID as DestContactID
      ,[DestPigGroupID]
      ,[Highlight]
      ,[ID]
      ,[MovementDate]
      ,[PigTypeID]
      ,[PMID]
      ,[PMLoadID]
      ,s.ContactID as SourceContactID
      ,[SourcePigGroupID]
      ,[TranSubTypeID]
      ,s.ContactName as Source
      ,d.ContactName as Destination
      ,HTP.[SPID] as SPID
	  ,HTP.[Timing] as Timing
	  ,HTP.[Days] as Days
      
from cftPM pm 
inner JOIN cftContact s WITH (NOLOCK) on pm.SourceContactID=s.ContactID
inner JOIN cftContact d WITH (NOLOCK) on pm.DestContactID=d.ContactID
inner Join [dbo].[cfv_HAT_PMSchedule] HTP on PM.DestContactID = HTP.[siteID] and pm.[TranSubTypeID] = HTP.[TranTypeID]
--where pm.MovementDate between cast(getdate() as date) AND cast(getdate() +21 as date)
where PMTypeID='01'
AND TranSubTypeID is not null
AND HTP.[Timing] like 'Post'





