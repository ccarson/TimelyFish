



CREATE VIEW [caredata].[CFV_SowFarrowEvent_orig]
AS
 select ev.Event_ID as event_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
      , ev.Eventdate
      , ev.WeekOfDate
      ,(farrow.[liveborn_gilts] + farrow.[liveborn_boars]) as QtyBornAlive
      ,farrow.[stillborn] as QtyStillBorn
      ,farrow.[mummified] as QtyMummy
      ,CASE WHEN farrow.[induced] = 0 THEN 'NO' ELSE 'YES' END as Induced
      ,CASE WHEN farrow.[assisted]  = 0 THEN 'NO' ELSE 'YES' END as Assisted
      ,ev.SowParity + coalesce(sowHdr.[starting_parity],0) as SowParity
      ,SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , ev.entry_creation_date
      , ev.last_update_date
  FROM (select site_id, identity_id, event_type, event_id 
      , eventdate
      ,CASE WHEN [eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,[eventdate]) -1), [eventdate]) END as WeekOfDate
	  , [creation_date] as entry_creation_date
	  , [last_update_date] as last_update_date
	  , row_number() over(partition by identity_id order by eventdate) as sowparity
		from caredata.bh_events  (NOLOCK)
		where [event_type] = 170 and [deletion_date] is NULL) ev
  inner join [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK) on IH.identity_id = ev.identity_id
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  left join [caredata].[EV_FARROWINGS] farrow (NOLOCK) on ev.identity_id = farrow.identity_id and ev.[event_id] = farrow.[event_id]  
  Where IH.deletion_date IS NULL  
  



