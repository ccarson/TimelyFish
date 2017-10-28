


CREATE VIEW [caredata].[CFV_SowRemoveEvent_Delete]
AS
SELECT  IH.identity_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
      , rd.[eventdate] as EventDate
      , CASE WHEN rd.[eventdate]is null THEN null ELSE DateAdd(d, - (DatePart(dw,rd.[eventdate]) -1), rd.[eventdate]) END as WeekOfDate
      , CASE WHEN death.[death_reason_id] is NULL and sale.[sale_reason_id] is NULL THEN NULL ELSE 
        CASE WHEN death.[death_reason_id] is not NULL and sale.[sale_reason_id] is NULL THEN 
        CASE WHEN death.[destroyed] > 0 THEN 'DESTROYED' ELSE 'DEATH' END ELSE 'CULL' END END as RemovalType
      , CASE WHEN death.[death_reason_id] is null THEN conSale.[longname] ELSE con.[longname] END  as PrimaryReason
	 -- , [caresystem].CFF_GetNonFarrowParity(IH.identity_id,rd.[eventdate]) as SowParity
      , SUBSTRING(gen.[longname],1,20) as SowGenetics
	  , rd.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  inner join [caredata].[bh_events] rd (NOLOCK) on IH.identity_id = rd.identity_id and rd.[event_type] in (298,299,300,301) and rd.[deletion_date] is Not NULL
  left join [caredata].[EV_DEATHS] death (NOLOCK) on IH.identity_id = death.[identity_id] and death.[event_id] = rd.[event_id]
  left join [caredata].[CONDITIONS] con (NOLOCK) on death.[death_reason_id] = con.[condition_id]
  left join [caredata].[EV_SALES] sale (NOLOCK) on IH.identity_id = sale.[identity_id] and sale.[event_id] = rd.[event_id]
  left join [caredata].[CONDITIONS] conSale (NOLOCK) on sale.[sale_reason_id] = conSale.[condition_id]
Where  IH.deletion_date IS NULL 
  and farm.site_id not in(99,101)	-- 20140708 sripley  remove access to farm 1 (not a valid site)
    
 


