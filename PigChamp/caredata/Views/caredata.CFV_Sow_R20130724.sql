




CREATE VIEW [caredata].[CFV_Sow_R20130724]
AS
SELECT  IH.identity_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , ID.[tattoo] as AlternateID
      , ed.[eventdate] as EntryDate
      ,CASE WHEN ed.[eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,ed.[eventdate]) -1), ed.[eventdate]) END as EntryWeekOfDate
      ,SUBSTRING(gen.[longname],1,20) as Genetics
      ,CASE WHEN sowHdr.[starting_parity] is null THEN 0 ELSE sowHdr.[starting_parity] END as InitialParity
      ,SUBSTRING(ef.[longname],1,20) as Origin
      ,sowHdr.[date_of_birth] as Birthdate
      ,SUBSTRING(sowHdr.[sire_identity],1,12) as Sire
      ,SUBSTRING(sowHdr.[dam_identity],1,12) as Dam
      ,rd.[eventdate] as RemovalDate
      ,CASE WHEN rd.[eventdate] is null THEN null ELSE  DateAdd(d, - (DatePart(dw,rd.[eventdate]) -1), rd.[eventdate]) END as RemovalWeekOfDate
      --,CASE WHEN death.[death_reason_id] is NULL and sale.[sale_reason_id] is NULL THEN NULL ELSE 
      -- CASE WHEN death.[death_reason_id] is not NULL and sale.[sale_reason_id] is NULL THEN 
      -- CASE WHEN death.[destroyed] > 0 THEN 'DESTROYED' ELSE 'DEATH' END ELSE 'CULL' END END as RemovalType  -- 20130708 replaced at Doran's request, resolve a Shari issue
--G:\shared\repro\cleanup queries.xlsx
--There are 2 queries where if the removal event is a ‘transferred off’ event, it does not need to be pulled into the spreadsheet, but it currently is.  
      ,CASE WHEN rd.[event_type] = 295 THEN 'TRANSFER' ELSE 
       CASE WHEN death.[death_reason_id] is NULL and sale.[sale_reason_id] is NULL THEN NULL ELSE 
       CASE WHEN death.[death_reason_id] is not NULL and sale.[sale_reason_id] is NULL THEN 
       CASE WHEN death.[destroyed] > 0 THEN 'DESTROYED' ELSE 'DEATH' END ELSE 'CULL' END END END as RemovalType
      ,CASE WHEN death.[death_reason_id] is null THEN conSale.[longname] ELSE con.[longname] END  as PrimaryReason
	  , ed.[creation_date] as entry_creation_date
	  , ed.last_update_date as entry_last_update_date
	  , rd.[creation_date] as removal_creation_date
	  , rd.last_update_date as removal_last_update_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join [caredata].[HDR_SOWS] sowHdr (NOLOCK) on IH.[identity_id] = sowHdr.[identity_id]
  inner join [caredata].[BH_IDENTITIES] ID (NOLOCK) on IH.[identity_id] = ID.[identity_id]
  left join [caredata].[GENETICS] gen (NOLOCK) on sowHdr.[genetics_id] = gen.[genetics_id]
  left join [caredata].[EXTERNAL_FARMS] ef (NOLOCK) on sowHdr.Origin_id = ef.farm_ID
  left join [caredata].[bh_events] ed (NOLOCK) on IH.identity_id = ed.identity_id and IH.site_id = ed.site_id and ed.[event_type] in (100, 105, 110, 150) and ed.[deletion_date] is NULL
  left join [caredata].[bh_events] rd (NOLOCK) on IH.identity_id = rd.identity_id and IH.site_id = rd.site_id and rd.[event_type] in (298,299,300,301,294,295) and rd.[deletion_date] is NULL
  left join [caredata].[EV_DEATHS] death (NOLOCK) on IH.identity_id = death.[identity_id] and death.[event_id] = rd.[event_id]
  left join [caredata].[CONDITIONS] con (NOLOCK) on death.[death_reason_id] = con.[condition_id]
  left join [caredata].[EV_SALES] sale (NOLOCK) on IH.identity_id = sale.[identity_id] and sale.[event_id] = rd.[event_id]
  left join [caredata].[CONDITIONS] conSale (NOLOCK) on sale.[sale_reason_id] = conSale.[condition_id]
Where  IH.deletion_date IS NULL 




