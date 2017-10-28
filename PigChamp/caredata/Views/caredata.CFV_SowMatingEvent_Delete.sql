
	  
CREATE VIEW [caredata].[CFV_SowMatingEvent_Delete]
AS
  select ev.Event_Id as EventID
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , CASE WHEN BIH.[identity_type] = 'A' THEN 'AI' ELSE 'MATING' END as MatingType
      , ev.[eventdate] as Eventdate
      , CASE WHEN ev.[eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,ev.[eventdate]) -1), ev.[eventdate]) END as WeekOfDate
      , SUBSTRING(BIH.[primary_identity],1,10) as SemenID
	  , sup.last_name as Observer
      , CASE WHEN mate.[time_of_day] = 'P' THEN 2 ELSE 1 END as HourFlag
      ,[caresystem].CFF_GetMateNbr(IH.identity_id,ev.[eventdate]) as MatingNbr
      --,[caresystem].CFF_GetNonFarrowParity(IH.identity_id,ev.[eventdate]) as SowParity
      , SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , ev.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] = 270 and ev.[deletion_date] is not NULL
  left join [caredata].[EV_MATINGS] mate (NOLOCK) on ev.identity_id = mate.identity_id and ev.[event_id] = mate.[event_id]
  left join [caredata].[SUPERVISORS] sup (NOLOCK) on ev.[supervisor_id] = sup.[supervisor_id]
  left join [caredata].[BH_IDENTITY_HISTORY] BIH (NOLOCK) on mate.[male_identity_id] = BIH.[identity_id] and IH.site_id = BIH.site_id
  
   where IH.deletion_date IS NULL
  

