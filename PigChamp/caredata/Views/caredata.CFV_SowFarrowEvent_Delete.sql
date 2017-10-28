


CREATE VIEW [caredata].[CFV_SowFarrowEvent_Delete]
AS
 select ev.Event_Id as EventID
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
      , ev.[eventdate] as Eventdate
      ,(farrow.[liveborn_gilts] + farrow.[liveborn_boars]) as QtyBornAlive
      ,farrow.[stillborn] as QtyStillBorn
      ,farrow.[mummified] as QtyMummy
      ,CASE WHEN farrow.[induced] = 0 THEN 'NO' ELSE 'YES' END as Induced
      ,CASE WHEN farrow.[assisted]  = 0 THEN 'NO' ELSE 'YES' END as Assisted
      --,[caresystem].CFF_GetFarrowParity(IH.identity_id,ev.[eventdate]) SowParity 
      ,SUBSTRING(gen.[longname],1,20) as SowGenetics
      , ev.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  inner join [caredata].[BH_IDENTITIES] ID (NOLOCK) on IH.[identity_id] = ID.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] = 170 and ev.[deletion_date] is Not NULL
  left join [caredata].[EV_FARROWINGS] farrow (NOLOCK) on ev.identity_id = farrow.identity_id and ev.[event_id] = farrow.[event_id]  
  Where IH.deletion_date IS NULL  
  and farm.site_id not in(99,101)	-- 20140708 sripley  remove access to farm 1 (not a valid site)
  


