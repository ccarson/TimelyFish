
create VIEW [caredata].[CFV_SowWeanEvent]
AS
      select  ev.Event_Id as EventID
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	   ,CASE WHEN ev.event_type = '265' THEN 'WEAN' ELSE 'PART WEAN' END as EventType 
      , ev.[eventdate] as EventDate
      , ev.WeekOfDate
	  , (wean.[weaned_boars] + wean.[weaned_gilts]) as Qty
      , sp.Parity  as SowParity
      ,  SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , ev.entry_creation_date
	  , ev.last_update_date
    FROM -- weaning event
	(select site_id, identity_id, event_id, event_type 
      , eventdate
      ,CASE WHEN [eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,[eventdate]) -1), [eventdate]) END as WeekOfDate
	  , [creation_date] as entry_creation_date
	  , [last_update_date] as last_update_date
		from caredata.bh_events  (NOLOCK)
		where [event_type] in (220,260,265) and [deletion_date] is NULL) ev
  inner join [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK) on IH.identity_id = ev.identity_id  
	and ih.site_id = ev.site_id  -- PigChamp recommended change to fix the issue (lacking weaning data for "transfer farms, m56 and m70"
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  -- farrowing event
  left join dbo.cft_SowParity sp (nolock)
	on IH.identity_id = sp.identity_id and IH.site_id = sp.site_id 
		and ev.eventdate between sp.eventdate and isnull(sp.enddate,getdate()) 	
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  left join [caredata].[EV_WEANINGS] wean (NOLOCK) on ev.identity_id = wean.identity_id and ev.[event_id] = wean.[event_id]  
  Where IH.deletion_date IS NULL  









