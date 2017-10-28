








CREATE VIEW [caredata].[CFV_SowParity_20140302]
AS
select IH.identity_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
      , ev.Parity + coalesce(sh.[starting_parity],0) as Parity
      , ev.EffectiveDate
      , ev.EffectiveWeekOfDate
	  , ev.entry_creation_date
	  , ev.last_update_date
from  (select site_id, identity_id, event_type
      , [eventdate] as EffectiveDate
      , CASE WHEN [eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,[eventdate]) -1), [eventdate]) END as EffectiveWeekOfDate
	  , [creation_date] as entry_creation_date
	  , [last_update_date] as last_update_date
	  , row_number() over(partition by identity_id order by eventdate) as parity
		from caredata.bh_events  (NOLOCK)
		where [event_type] = 170 and [deletion_date] is NULL) ev
inner join [caredata].[BH_IDENTITY_HISTORY] IH WITH (NOLOCK)
	on IH.identity_id = ev.identity_id
inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id]
left join [caredata].[HDR_SOWS] sh (NOLOCK) on sh.identity_id = IH.identity_id
where SUBSTRING(IH.[primary_identity],1,12) not in ('463072', '442231')
and SUBSTRING(IH.[primary_identity],1,12) <> '442231'--SUBSTRING(farm.[farm_name],1,8) = 'C53' and SUBSTRING(IH.[primary_identity],1,12) = '463072'  

UNION  

   select IH.identity_id
	  , SUBSTRING(farm.[farm_name],1,8) AS FarmID
	  , SUBSTRING(IH.[primary_identity],1,12) as SowID
	  , ev.parity - 1 -- uses a count, for gilts the parity is zero
      , ev.EffectiveDate
      , ev.EffectiveWeekOfDate
	  , ev.entry_creation_date
	  , ev.last_update_date
from  (select site_id, identity_id, event_type
      , [eventdate] as EffectiveDate
      , CASE WHEN [eventdate]is null THEN null ELSE  DateAdd(d, - (DatePart(dw,[eventdate]) -1), [eventdate]) END as EffectiveWeekOfDate
	  , [creation_date] as entry_creation_date
	  , [last_update_date] as last_update_date
	  , row_number() over(partition by identity_id order by eventdate) as parity
		from caredata.bh_events  (NOLOCK)
		where [event_type] in (100,110) and [deletion_date] is NULL) ev
inner join [caredata].[BH_IDENTITY_HISTORY] IH WITH (NOLOCK)
	on IH.identity_id = ev.identity_id
inner join [careglobal].[FARMS] farm (NOLOCK) on IH.site_id = farm.[site_id]
where SUBSTRING(IH.[primary_identity],1,12) not in ('463072', '442231')
--SUBSTRING(farm.[farm_name],1,8) = 'C53' and SUBSTRING(IH.[primary_identity],1,12) = '463072'

  








