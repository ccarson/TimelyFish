﻿

CREATE VIEW [caredata].[CFV_SowNurseEvent_Delete]
AS
  select ev.Event_Id as EventID
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , 'NURSE ON' as EventType
      , ev.[eventdate] as EventDate
	  , nurse.piglets_on as Qty
      --, [caresystem].CFF_GetNonFarrowParity(IH.identity_id,ev.[eventdate]) as SowParity
      , SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , ev.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] = 260 and ev.[deletion_date] is Not NULL
  left join [caredata].[EV_NURSE_ON] nurse (NOLOCK) on ev.identity_id = nurse.[identity_id] and ev.[event_id] = nurse.[event_id]
  
  where  IH.deletion_date IS NULL
    
 

