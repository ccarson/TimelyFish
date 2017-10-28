






CREATE VIEW [caredata].[CFV_SowMatingEvent_orig]
AS
select ev.Event_Id as EventID
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , CASE WHEN BIH.[identity_type] = 'A' THEN 'AI' ELSE 'MATING' END as MatingType
      , ev.Eventdate
      , ev.WeekOfDate
      , SUBSTRING(BIH.[primary_identity],1,10) as SemenID
	  , sup.last_name as Observer
      , CASE WHEN ev.[time_of_day] = 'P' THEN 2 ELSE 1 END as HourFlag
      , ev.sowmating as MatingNbr
      , isnull(fe.Parity,0) + coalesce(sowHdr.[starting_parity],0) as SowParity
      , SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , ev.entry_creation_date
	  , ev.last_update_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK) 
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  left join (
		  select m.site_id, m.identity_id, m.event_id, m.supervisor_id , m.eventdate, em.time_of_day, em.male_identity_id
			  ,CASE WHEN m.[eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,m.[eventdate]) -1), m.[eventdate]) END as WeekOfDate
			  , m.[creation_date] as entry_creation_date
			  , m.[last_update_date] as last_update_date
			  , row_number() over(partition by m.identity_id, em.service_group order by m.eventdate) as sowmating
				from caredata.bh_events m (NOLOCK)
				inner join caredata.ev_matings em (nolock)
					on em.identity_id = m.identity_id and em.event_id = m.event_id
					) ev	on IH.identity_id = ev.identity_id
---- mating event
  left join dbo.cft_sowparity fe (nolock)
	on fe.site_id = ev.site_id and fe.identity_id = ev.identity_id and ev.eventdate >= fe.eventdate and ev.eventdate < isnull(fe.enddate,getdate())
--  -- farrowing event	
  left join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  left join [caredata].[SUPERVISORS] sup (NOLOCK) on ev.[supervisor_id] = sup.[supervisor_id]
  left join [caredata].[BH_IDENTITY_HISTORY] BIH (NOLOCK) on ev.[male_identity_id] = BIH.[identity_id] and IH.site_id = BIH.site_id  
  Where IH.deletion_date IS NULL 






