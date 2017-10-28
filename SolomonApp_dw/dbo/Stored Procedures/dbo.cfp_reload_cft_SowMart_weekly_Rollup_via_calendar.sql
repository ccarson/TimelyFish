

/* steps
1. site loop get next site
2. truncate processing calendar table
3. load it for the site
4. delete from cft_sowmart_weekly_rollup where siteid matches (300+ rows)
5. insert into cft_sowmart_weekly_rollup new data from processing calendar table
6. get next siteid
7. do reporting group and feed updates on the weekly rollup table.
*/

CREATE PROCEDURE [dbo].[cfp_reload_cft_SowMart_weekly_Rollup_via_calendar]
AS
BEGIN


declare @farmid varchar(30)

declare get_farmid cursor 
for select distinct farm_name FROM [$(PigCHAMP)].[careglobal].[FARMS] 
--where farm_name in ('C02','C09')
order by farm_name

open get_farmid

fetch next from get_farmid into @farmid

while (@@fetch_status <> -1)
begin

truncate table cft_sowmart_processing_calendar

declare @curr_picyear_week varchar(6)
select @curr_picyear_week = picyear_week from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] where cast(daydate as date) = cast(getdate() as date)

insert into cft_sowmart_processing_calendar
select a.picyear_week, a.daydate,a.siteid,a.identityid
, case when gest.sowid is not null then 1 else 0 end gest_flg
, case when lact.sowid is not null then 1 else 0 end lact_flg
from
(
select dw.picyear_week, dw.daydate,actv.siteid, actv.identityid
from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dw
join 
	(select siteid, identityid, min(arrival_date) Indt, max(ISNULL(dateadd(dd,-1,dd.removal_date),getdate()) ) outdt
	from  [dbo].[cft_SowMart_Detail_data_stg] dd
	where farmid = @farmid 
	group by siteid, identityid) actv
		on dw.daydate between actv.Indt and actv.Outdt
where dw.picyear_week between '09wk01' and @curr_picyear_week)  a
left join  [dbo].[cft_SowMart_Detail_data_stg] gest
	on gest.siteid = a.siteid and gest.identityid = a.identityid 
	and a.daydate between gest.mating_date and dateadd(d,-1,isnull(gest.fallout_date,isnull(gest.farrow_date,isnull(dateadd(dd,-1,gest.removal_date), getdate()))))
left join  [dbo].[cft_SowMart_Detail_data_stg] lact
	on lact.siteid = a.siteid and lact.identityid = a.identityid 
	and a.daydate  between lact.farrow_date and dateadd(d,-1, ISNULL(lact.final_wean_date,ISNULL(dateadd(dd,-1,lact.removal_date),getdate())))
option( recompile ) ;

delete from [dbo].[cft_SowMart_weekly_Rollup_stg]
where farmid = @farmid

insert into [dbo].[cft_SowMart_weekly_Rollup_stg]
select picyear_week,@farmid,siteid
, avg(total_sow_qty) total_sow_qty
, avg(gest_sow_qty) gest_sow_qty
, avg(lact_sow_qty) lact_sow_qty
, avg(nonprod_sow_qty) nonprod_sow_qty
, sum(total_sow_days) total_sow_days
, sum(gest_sows_days) gest_sows_days
, sum(lact_sows_days) lact_sows_days
, sum(nonprod_sow_days) nonprod_sow_days
,null -- gest_feed_lbs
,null -- lact_feed_lbs
,null -- other_feed_lbs
,null -- reportinggroupid
,getdate() -- load_dt
from
(select picyear_week,daydate, siteid
, count(distinct identityid) total_sow_qty		-- not an average, but the number of sows that came through the site that week.... will be high.. need to do this by day then get average for the week
, count(distinct case when gest_flg = 1 and lact_flg = 0 then identityid else null end) gest_sow_qty
, count(distinct case when lact_flg = 1 and gest_flg = 0 then identityid else null end) lact_sow_qty
, count(distinct case when lact_flg = 0 and gest_flg = 0 then identityid else null end) nonprod_sow_qty
, sum(case when (gest_flg = 1 or lact_flg = 1) or (gest_flg = 0 and lact_Flg = 0) then 1 else 0 end ) total_sow_days
, sum(case when gest_flg = 1 and lact_flg = 0 then 1 else 0 end ) gest_sows_days
, sum(case when gest_flg = 0 and lact_flg = 1 then 1 else 0 end ) lact_sows_days
, sum(case when gest_flg = 0 and lact_flg = 0 then 1 else 0 end ) nonprod_sow_days
from cft_sowmart_processing_calendar (nolock)
group by picyear_week,daydate, siteid) xx
group by picyear_week, siteid
order by picyear_week, siteid
--select picyear_week, @farmid, siteid
--, count(distinct identityid) total_sow_qty		-- not an average, but the number of sows that came through the site that week.... will be high.. need to do this by day then get average for the week
--, count(distinct case when gest_flg = 1 and lact_flg = 0 then identityid else null end) gest_sow_qty
--, count(distinct case when lact_flg = 1 and gest_flg = 0 then identityid else null end) lact_sow_qty
--, count(distinct case when lact_flg = 0 and gest_flg = 0 then identityid else null end) nonprod_sow_qty
--, sum(case when gest_flg = 1 or lact_flg = 1 then 1 else 0 end ) total_sow_days
--, sum(case when gest_flg = 1 and lact_flg = 0 then 1 else 0 end ) gest_sows_days
--, sum(case when gest_flg = 0 and lact_flg = 1 then 1 else 0 end ) lact_sows_days
--, sum(case when gest_flg = 0 and lact_flg = 0 then 1 else 0 end ) nonprod_sow_days
--,null -- gest_feed_lbs
--,null -- lact_feed_lbs
--,null -- other_feed_lbs
--,null -- reportinggroupid
--,getdate() -- load_dt
--from cft_sowmart_processing_calendar (nolock)
--group by picyear_week, siteid
--order by picyear_week, siteid
option( recompile ) ;




	fetch next from get_farmid into @farmid

end

close get_farmid
deallocate get_farmid


update  dbo.cft_sowmart_weekly_rollup_stg
set reportinggroupid = pf.reportinggroupid
from  dbo.cft_sowmart_weekly_rollup_stg wr	-- farmid
join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dw
	on dw.picyear_week = wr.picyear_week and dw.dayname = 'sunday'
join [$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
	on f.farm_name = wr.farmid and f.site_id = wr.siteid
inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
	on pff.contactid = cast(f.farm_number as int)
join [$(CFApp_PigManagement)].dbo.cft_pig_flow pf (nolock)
	on pf.pigflowid = pff.pigflowid and dw.daydate between pigflowfromdate and isnull(pigflowtodate,getdate())
where pf.reportinggroupid <> 0
--and wr.picyear_week between '14wk01' and '14wk18' 

update [dbo].[cft_SowMart_weekly_Rollup_stg]
set [gest_feed_lbs] = DelvFeedlbs
from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
join (select dw.picyear_week, f.farm_name, substring([InvtIdDel],1,4) ration, sum(qtydel) DelvFeedlbs
	  from (select picyear_week, min(daydate) min_daydate, max(daydate) max_daydate from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] group by picyear_week ) dw
		join [$(SolomonApp)].[dbo].[cftFeedOrder] fo (nolock)
			  on fo.datedel between min_daydate and max_daydate
		join [$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
			on cast(f.farm_number as int) = fo.contactid
		where 1=1 --dw.picyear_week between '14wk01' and '14wk18' 
		and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) in ('021M')
		group by dw.picyear_week,f.farm_name, substring([InvtIdDel],1,4) ) ration
	on ration.picyear_week = roll.picyear_week and ration.farm_name = roll.farmid
-- (15647 row(s) affected)   00:02:14


update [dbo].[cft_SowMart_weekly_Rollup_stg]
set [lact_feed_lbs] = DelvFeedlbs
from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
join (select dw.picyear_week, f.farm_name, substring([InvtIdDel],1,4) ration, sum(qtydel) DelvFeedlbs
	  from (select picyear_week, min(daydate) min_daydate, max(daydate) max_daydate from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] group by picyear_week ) dw
		join [$(SolomonApp)].[dbo].[cftFeedOrder] fo (nolock)
			  on fo.datedel between min_daydate and max_daydate
		join [$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
			on cast(f.farm_number as int) = fo.contactid
		where 1=1 --dw.picyear_week between  '14wk01' and '14wk18'
		and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) in ('031M')
		group by dw.picyear_week,f.farm_name, substring([InvtIdDel],1,4) ) ration
	on ration.picyear_week = roll.picyear_week and ration.farm_name = roll.farmid
--(14538 row(s) affected)  00:00:34 


update [dbo].[cft_SowMart_weekly_Rollup_stg]
set [other_feed_lbs] = DelvFeedlbs
from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
join (select dw.picyear_week, f.farm_name, substring([InvtIdDel],1,4) ration, sum(qtydel) DelvFeedlbs
	  from (select picyear_week, min(daydate) min_daydate, max(daydate) max_daydate from [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] group by picyear_week ) dw
		join [$(SolomonApp)].[dbo].[cftFeedOrder] fo (nolock)
			  on fo.datedel between min_daydate and max_daydate
		join [$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
			on cast(f.farm_number as int) = fo.contactid
		where 1=1 --dw.picyear_week between  '14wk01' and '14wk18'
		and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) not in ('021m','031M')
		group by dw.picyear_week,f.farm_name, substring([InvtIdDel],1,4) ) ration
	on ration.picyear_week = roll.picyear_week and ration.farm_name = roll.farmid
--(2245 row(s) affected)  00:00:03

---- update LDC or ON farms
--update [dbo].[cft_SowMart_weekly_Rollup_stg]
--set [Gest_feed_lbs] = DelvFeedlbs
--from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
--join (select dw.picyear_week, replace(sb.contactname,'0','') farmid, sum(qtydel) DelvFeedlbs
--from 
--(select picyear_week, min(daydate) min_daydate, max(daydate) max_daydate from  dbo.cftDayDefinition_WithWeekInfo group by picyear_week ) dw

--join [$(SolomonApp)].[dbo].[cftFeedOrder] fo (nolock)
--			  on fo.datedel between dw.min_daydate and dw.max_daydate

--join (SELECT distinct b.[ContactID] grpcontactid,b.barnnbr, s1.contactname, s1.contactid
--	  FROM [CentralData].[dbo].[Barn] b (nolock)
--      join ( select s.siteid, s.contactid, c.contactname
--			 from [$(CentralData)].dbo.site  s (nolock)
--		     join [$(CentralData)].dbo.contact c (nolock)
--						on c.contactid = s.contactid
--					 where siteid in (8121,8122) ) s1
--						on s1.siteid = b.siteid and replace(s1.contactname,'0','') = substring(b.barnnbr,1,3) 
--		     )  sb
--			on sb.barnnbr = fo.barnnbr and cast(sb.grpcontactid as int) = cast(fo.contactid as int) 

--where 1=1 --dw.picyear_week between  '14wk01' and '14wk18'
--and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) = '021m'  -- 021 gest, 031 lact, other
--group by dw.picyear_week, sb.contactname) ration
--	on ration.picyear_week = roll.picyear_week and ration.farmid = roll.farmid

update [dbo].[cft_SowMart_weekly_Rollup_stg]
set gest_feed_lbs = ration.gbl_gest_feed_lbs
from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
left join
(
select (fnbrs.sow_days/cnbrs.sow_days) * fo.qtydel as gbl_gest_feed_lbs, cnbrs.picyear_week, fnbrs.farmid
from
-- sowmart_weekly_rollup site level amounts
(select picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end contactid
--, sum(Gest_feed_lbs) Gest_feed_lbs
, sum(gest_sow_days) + sum(nonprod_sow_days) as sow_days
from [dbo].[cft_SowMart_weekly_Rollup_stg] 
where farmid in ('c27','c29','c31','c32','c34','c36')
group by picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end
  having sum(lact_sow_days) > 0) as cnbrs
  
left join
-- sowmart_weekly_rollup farm level amounts
  (select picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end contactid
, farmid
--, sum(Gest_feed_lbs) Gest_feed_lbs
, sum(gest_sow_days) + sum(nonprod_sow_days) as sow_days
from [dbo].[cft_SowMart_weekly_Rollup_stg] 
where farmid in ('c27','c29','c31','c32','c34','c36')
group by picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end, farmid) as fnbrs
	on fnbrs.picyear_week = cnbrs.picyear_week and fnbrs.contactid = cnbrs.contactid

left join
-- cftfeedorder numbers
	(select  picyear_week,contactid, sum(qtydel) qtydel
	from [$(SolomonApp)].[dbo].[cftFeedOrder] (nolock) 
	left join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dw
		on dw.daydate = datedel
	 where contactid in ('004001','004002') 
	 and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) = '021m'
	 group by picyear_week, contactid
	 ) fo
		on fo.picyear_week = cnbrs.picyear_week and fo.contactid= cnbrs.contactid
) ration
	on ration.picyear_week = roll.picyear_week and ration.farmid = roll.farmid
where roll.farmid in ('c27','c29','c31','c32','c34','c36')
	
	
	
	
	

---- update LDC or ON farms	
--update [dbo].[cft_SowMart_weekly_Rollup_stg]
--set [lact_feed_lbs] = DelvFeedlbs
--from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
--join (select dw.picyear_week, replace(sb.contactname,'C0','C') farmid, sum(qtydel) DelvFeedlbs
--from 
--(select picyear_week, min(daydate) min_daydate, max(daydate) max_daydate from  dbo.cftDayDefinition_WithWeekInfo group by picyear_week ) dw

--join [$(SolomonApp)].[dbo].[cftFeedOrder] fo (nolock)
--			  on fo.datedel between dw.min_daydate and dw.max_daydate

--join (SELECT distinct b.[ContactID] grpcontactid,b.barnnbr, s1.contactname, s1.contactid
--	  FROM [CentralData].[dbo].[Barn] b (nolock)
--      join ( select s.siteid, s.contactid, c.contactname
--			 from [$(CentralData)].dbo.site  s (nolock)
--		     join [$(CentralData)].dbo.contact c (nolock)
--						on c.contactid = s.contactid
--					 where siteid in (8121,8122) ) s1
--						on s1.siteid = b.siteid and replace(s1.contactname,'C0','C') = substring(b.barnnbr,1,3) 
--		     )  sb
--			on sb.barnnbr = fo.barnnbr and cast(sb.grpcontactid as int) = cast(fo.contactid as int) 

--where 1=1 --dw.picyear_week between  '14wk01' and '14wk18'
--and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) = '031m'  -- 021 gest, 031 lact, other
--group by dw.picyear_week, sb.contactname) ration
--	on ration.picyear_week = roll.picyear_week and ration.farmid = roll.farmid

update [dbo].[cft_SowMart_weekly_Rollup_stg]
set lact_feed_lbs = ration.gbl_lact_feed_lbs
from [dbo].[cft_SowMart_weekly_Rollup_stg] Roll
left join
(
select (fnbrs.sow_days/cnbrs.sow_days) * fo.qtydel as gbl_lact_feed_lbs, cnbrs.picyear_week, fnbrs.farmid
from
-- sowmart_weekly_rollup site level amounts
(select picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end contactid
--, sum(lact_feed_lbs) lact_feed_lbs
, sum(lact_sow_days) as sow_days
from [dbo].[cft_SowMart_weekly_Rollup_stg] 
where farmid in ('c27','c29','c31','c32','c34','c36')
group by picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end
having sum(lact_sow_days) > 0) cnbrs
  
left join
-- sowmart_weekly_rollup farm level amounts
  (select picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end contactid
, farmid
--, sum(lact_feed_lbs) lact_feed_lbs
, sum(lact_sow_days) as sow_days
from [dbo].[cft_SowMart_weekly_Rollup_stg] 
where farmid in ('c27','c29','c31','c32','c34','c36')
group by picyear_week
, case when farmid in ('c27','c29','c31') then '004001'
	   when farmid in ('c32','c34','c36') then '004002'
  end, farmid) as fnbrs
	on fnbrs.picyear_week = cnbrs.picyear_week and fnbrs.contactid = cnbrs.contactid

left join
-- cftfeedorder numbers
	(select  picyear_week,contactid, sum(qtydel) qtydel
	from [$(SolomonApp)].[dbo].[cftFeedOrder] (nolock) 
	left join [$(SolomonApp)].[dbo].[cfvDayDefinition_WithWeekInfo] dw
		on dw.daydate = datedel
	 where contactid in ('004001','004002') 
	 and reversal = 0 and status = 'C' and substring([InvtIdDel],1,4) = '031m'
	 group by picyear_week, contactid
	 ) fo
		on fo.picyear_week = cnbrs.picyear_week and fo.contactid= cnbrs.contactid
) ration
	on ration.picyear_week = roll.picyear_week and ration.farmid = roll.farmid
where roll.farmid in ('c27','c29','c31','c32','c34','c36')

	


end

 












