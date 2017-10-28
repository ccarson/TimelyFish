

CREATE VIEW [caredata].[CFV_SowParity_Delete]
AS
select IH.identity_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  --,[caresystem].CFF_GetFarrowParity(IH.identity_id,ev.[eventdate]) Parity
      , ev.[eventdate] as EffectiveDate
	  , ev.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH WITH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] = 170 and ev.[deletion_date] is NOT NULL
  Where IH.deletion_date IS NULL
UNION  
   select IH.identity_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  --,[caresystem].CFF_GetNonFarrowParity(IH.identity_id,ev.[eventdate]) Parity
      , ev.[eventdate] as EffectiveDate
	  , ev.[deletion_date] as deletion_date
  FROM [caredata].[BH_IDENTITY_HISTORY] IH  WITH (NOLOCK)
  inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id] 
  inner join caredata.bh_events ev (NOLOCK) on IH.identity_id = ev.identity_id and ev.[event_type] = 100 and ev.[deletion_date] is Not NULL
  Where IH.deletion_date IS NULL
  

