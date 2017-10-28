

CREATE VIEW [caredata].[CFV_SowRetagEvent]
AS
  select SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , SUBSTRING(retag.old_identity,1,12) as OldIdentity
      , ev.[eventdate] as EventDate
	  , ev.[creation_date] as entry_creation_date
	  , ev.[last_update_date] as last_update_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] in (230,231) and ev.[deletion_date] is NULL
  inner join [caredata].[EV_RETAG] retag (NOLOCK) on ev.identity_id = retag.[identity_id] and ev.[event_id] = retag.[event_id]
  
  where  IH.deletion_date IS NULL
  

