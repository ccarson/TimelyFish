

CREATE VIEW [caredata].[CFV_SowGroupEvent_Delete]
AS
  Select EventID, FarmID, SowID,GroupID, min(Eventdate) as Eventdate, SowGenetics, min(deletion_date) as deletion_date from (
  select  ev.Event_Id as EventID
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , SUBSTRING(mate.[service_group],1,8) as GroupID
      , ev.[eventdate] as Eventdate
      --,[caresystem].CFF_GetNonFarrowParity(IH.identity_id,ev.[eventdate]) as Parity
      ,SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , ev.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  inner join [caredata].[BH_IDENTITIES] ID (NOLOCK) on IH.[identity_id] = ID.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] = 270 and ev.[deletion_date] is Not NULL
  left join [caredata].[EV_MATINGS] mate (NOLOCK) on ev.identity_id = mate.identity_id and ev.[event_id] = mate.[event_id]
    
  where IH.deletion_date IS NULL
  ) as am
 group by am.EventID, am.FarmID, am.SowID,GroupID, am.SowGenetics 
  

