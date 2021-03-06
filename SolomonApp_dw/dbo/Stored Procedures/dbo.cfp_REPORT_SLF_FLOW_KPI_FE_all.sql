﻿













-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_FE_rank
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_FE_all]
	@pg_week char(6)
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

--declare @pg_week char(6)
--select @pg_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
--where daydate = cast(getdate() as date)



declare @startdate datetime
declare @enddate datetime
declare @fstartdate datetime
declare @fenddate datetime

declare @wk00 char(6), @wk23 char(6), @wk25 char(6), @wk26 char(6), @wk42 char(6), @wk48 char(6), @wk17 char(6), @wk51 char(6), @wk68 char(6), @wk49 char(6), @wk74 char(6), @wk77 char(6)
, @wk94 char(6), @start char(6)

-- marketing pig time frames
-- get datetime value for last day of the market interval
select @enddate = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week
-- get picyear_week value for first day of the market interval
select @wk26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-26,@enddate)
-- get datetime value for first day of the interval
select @startdate = min(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @wk26

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)


set @wk00 = @pg_week
select @wk23 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-23,@enddate)
select @wk25 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-25,@enddate)
select @wk26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-26,@enddate)
select @wk68 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-68,@enddate)
select @wk42 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-42,@enddate)
select @wk48 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-48,@enddate)
select @wk49 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-49,@enddate)
select @wk17 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-17,@enddate)
select @wk51 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-51,@enddate)
select @wk74 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-74,@enddate)
select @wk77 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-77,@enddate)
select @wk94 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-94,@enddate)




select distinct reportinggroupid
, Reporting_Group_Description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @wk25 and @pg_week	-- 26 weeks ago    and inputted week

 
 
--  translate the reportinggroupid to the farmid(farm text from the reporting_group_description
declare @farmid_list varchar(500)

--Select @farmid_list = COALESCE(@farmid_list + ', ', '') + reporting_group_description 
--from #pf_list
select @farmid_list = COALESCE(@farmid_list + ', ', '') + 
case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end
from #pf_list

select distinct reportinggroupid
,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end reporting_group_description
, pg_week, dw23.picyear_week as w23, dw26.picyear_week as w26 
into #lookback
from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
where pg_week between @wk26 and @pg_week

declare @farmid varchar(500)

select pcf.farm_name, reportinggroupid, reporting_group_description
into #rptgrp_farmid
from 
(select distinct reportinggroupid 
	,COALESCE(@farmid + ', ', '') + 
	case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
		 when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
		 else reporting_group_description
	end reporting_group_description 
from [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @wk26 and @pg_week) rglist
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 

--   
 
 -- the slf kpi report requests a picyear_week value.   this represents the last picyear_week value of a 6 month interval (a market pig's sold interval)
-- sow farrowing and weaning events that create the pigs marketed occur in a prior 6 month interval
-- this also applies to the feed consumed by the sows.


select reportinggroupid, Reporting_group_description	--, phase
, @wk51 starting_picyear_week, @wk00 ending_picyear_week
, sum(prim_wt) as wtsold
, sum(prim_qty) as qtysold
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #w51w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @wk51 and @wk00 
  and phase in ('FIN', 'wtf')
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;

-- estimated to actual wean
select [FarmID]
      ,sum([Wean_qty]) Wean_qty
      ,sum([Litters_weaned_qty]) Litters_weaned_qty
into #EAwean_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk74 and @wk23
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

-- estimated to actual farrow
select [FarmID]
      ,sum([Litters_farrowed_qty]) Litters_farrowed_qty
into #EAfarrow_pre
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk77 and @wk26
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( cast(sum(wean_qty) as float)/cast(sum(litters_weaned_qty) as float) ) gpw_per_sowwean
, sum(litters_farrowed_qty) litters_farrowed_qty
into #EA
	from
	(select distinct fid.reportinggroupid, f.Litters_farrowed_qty, w.Wean_qty, w.Litters_weaned_qty
	from #EAwean_pre w
	join #EAfarrow_pre f 
		on f.farmid = w.farmid
join #rptgrp_farmid fid
	on fid.farm_name = w.farmid
	) xx
	group by xx.reportinggroupid
having sum(litters_weaned_qty) > 0	-- 20141212 prevent divide by zero issues.
	
select fw.farmid, sum([Lact_sow_Days]) Lact_sow_Days
into #Ldays_pre
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk77 and @wk23
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( sum([Lact_sow_Days]) / 385) lday385
into #Ldays
	from
	(select distinct fid.reportinggroupid, f.*
	from #Ldays_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid



select fw.farmid, sum([gest_sow_Days]) gest_sow_Days
into #Gdays_pre
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
where fw.picyear_week between @wk94 and @wk26 
and fw.farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
group by fw.farmid

select xx.reportinggroupid, ( sum([gest_sow_Days]) / 483) gday483
into #Gdays
	from
	(select distinct fid.reportinggroupid, f.*
	from #Gdays_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid




-- lactating Sow Info

select farmid
, sum(lact_sow_days) Ldays, avg(lact_sow_qty) avgLsowcnt
, sum(lact_feed_lbs) lact_feed_lbs
, sum(cast(lact_feed_lbs as float))/sum(cast(lact_sow_days as float)) as lacfeedlbsperday
into #LSowinfo_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk51 and @wk23		
		and farmid in (Select rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
having sum(cast(lact_sow_days as float)) > 0  -- fix divide by zero issue.	20141212 sripley 

select xx.reportinggroupid
, sum(Ldays) Ldays
, sum(lact_feed_lbs) lact_feed_lbs
, sum(cast(lact_feed_lbs as float))/sum(cast(Ldays as float)) as lacfeedlbsperday
into #LSowinfo
	from
	(select distinct fid.reportinggroupid, f.*
	from #LSowinfo_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid
	
	
	

select farmid
, sum(lact_days_qty) lact_days_qty
, cast(count(distinct sowid+cast(sowparity as varchar(2))) as float) sow_qty
into #LSowAvg_pre
	 from  [dbo].[cft_SowMart_Detail_data]
where isnull(farrow_picyear_week,getdate()) between @wk51 and @wk23	
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 
select xx.reportinggroupid
, sum(cast(lact_days_qty as float))/ sum(cast(sow_qty as float)) avgLdays
into #LSowAvg
	from
	(select distinct fid.reportinggroupid, f.*
	from #LSowAvg_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid
having sum(sow_qty) > 0  -- fix divide by zero issue.	20141212 sripley 
	 



-- Gestating Sow Info

select farmid
, sum(gest_sow_days) gest_sow_days	
, sum(gest_feed_lbs) gest_feed_lbs
, sum(nonprod_sow_days) nonprod_sow_days
into #GSowinfo_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk68 and @wk26
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(gest_sow_days) Gdays	
, sum(gest_feed_lbs) gest_feed_lbs
, sum(cast(gest_feed_lbs as float))/( sum(cast(gest_sow_days as float)) + sum(cast(nonprod_sow_days as float)) ) as gesfeedlbsperday
into #GSowinfo
	from
	(select distinct fid.reportinggroupid, f.*
	from #GSowinfo_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid
having sum(cast(gest_sow_days as float)) + sum(cast(nonprod_sow_days as float)) > 0  -- prevent divide by zero issue.	20141212 sripley 


select farmid
, sum(gest_days_qty) gest_days_qty	
, cast(count(distinct sowid+cast(sowparity as varchar(2))) as float) sow_qty
into #GSowAvg_pre
	 from  [dbo].[cft_SowMart_Detail_data]
where isnull(farrow_picyear_week,getdate()) between @wk68 and @wk26
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(gest_days_qty)/sum(sow_qty) avgGdays
into #GSowAvg
	from
	(select distinct fid.reportinggroupid, f.*
	from #GSowAvg_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid
having sum(sow_qty) > 0 -- prevent divide by zero issue.	20141212 sripley 



 
-- market hog information     nursery,fin,wtf feed consumed, pig lbs sold   ??  include dead weight  too??
select es.reportinggroupid, sum(es.feed_qty) feed_qty
, sum(es.[Prim_Wt]) + sum(es.[Cull_Wt]) + sum(es.[DeadOnTruck_Wt]) + sum(es.[DeadInYard_Wt]) + sum(es.[Condemn_Wt]) 
  + sum(es.moveout_wt) + sum(es.transferout_wt) + sum(es.pigdeathTD_wt) + sum(es.transportdeath_wt) + sum(es.transfertotailender_wt)    
as mtkwgt	-- total weight produced
, sum(es.[Prim_qty]) + sum(es.[Cull_qty]) + sum(es.[DeadOnTruck_qty]) + sum(es.[DeadInYard_qty]) + sum(es.[Condemn_qty]) 
  + sum(es.moveout_qty) + sum(es.transferout_qty) + sum(es.pigdeathTD_qty) + sum(es.transportdeath_qty) + sum(es.transfertotailender_qty)    
as mtkqty	-- total head produced
into #market
from  dbo.cft_slf_essbase_data es (nolock)
where es.pg_week between @wk25 and @pg_week
group by es.reportinggroupid

select reportinggroupid, Reporting_group_description	--, phase
, @start starting_picyear_week, @pg_week ending_picyear_week
  , sum(deadontruck_qty) + sum(deadinyard_qty)+ sum(condemn_qty) dotdiyc
  , sum(deadontruck_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as dotpct
  , sum(deadinyard_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as diypct
  , sum(condemn_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as compct
  , sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
  , sum(prim_qty)  / (sum(prim_qty) + sum(cull_qty) )*100 as primpct	-- per marketed pig
  , sum(cull_qty)  / (sum(prim_qty) + sum(cull_qty) )*100 as cullpct	-- per marketed pig
  , sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) as wgt_produced
  , sum(prim_qty) + sum(cull_qty) + sum(deadontruck_qty) + sum(deadinyard_qty) + sum(condemn_qty) as head_produced
into #mkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @start and @pg_week
  and phase in ('FIN', 'wtf')
  group by reportinggroupid, Reporting_group_description	--, phase
having (sum(prim_qty) + sum(cull_qty)) > 0 -- prevent divide by zero issues.
and (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) ) > 0
order by Reporting_group_description



select farmid
, sum(lact_feed_lbs) lact_feed_lbs
into #w5123_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk51 and @wk23
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(lact_feed_lbs) lact_feed_lbs
into #w5123
	from
	(select distinct fid.reportinggroupid, f.*
	from #w5123_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid


select farmid
,sum(gest_feed_lbs) gest_feed_lbs
into #w6826_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between @wk68 and @wk26
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid

select xx.reportinggroupid
, sum(gest_feed_lbs) gest_feed_lbs
into #w6826
	from
	(select distinct fid.reportinggroupid, f.*
	from #w6826_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid
	
	


select farmid
, sum(lact_days_qty) lact_days_qty	
, sum(gest_days_qty) gest_days_qty	
, cast(count(distinct sowid+cast(sowparity as varchar(2))) as float) sow_qty
into #cycles_dd_pre
	 from  [dbo].[cft_SowMart_Detail_data]
where farrow_picyear_week between @wk51 and @pg_week
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 
select farmid
,sum(nonprod_sow_days) nonprod_sow_days
,sum(nonprod_sow_qty) nonprod_sow_qty
into #cycles_wr_pre
	 from  [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between @wk51 and @pg_week
		and farmid in (Select distinct rtrim(ltrim(value)) From  dbo.cffn_SPLIT_STRING(@farmid_list,','))
	 group by farmid
	 
select x1.reportinggroupid, x1.avgldays, x1.avggday, x2.nondays
,  x1.avgldays+x1.avggday+x2.nondays Tdays
, 365/(x1.avgldays+x1.avggday+x2.nondays) cyc
into #cycles
from 
(select xx.reportinggroupid
 , sum(cast(lact_days_qty as float))/sum(cast(sow_qty as float)) avgLdays
 , sum(cast(gest_days_qty as float))/sum(cast(sow_qty as float)) avgGday
 from
	(select distinct fid.reportinggroupid, f.*
	from #cycles_dd_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid
	having sum(sow_qty) > 0) x1
join  
(select xx.reportinggroupid, sum(nonprod_sow_days)/sum(nonprod_sow_qty) nondays
 from
	(select distinct fid.reportinggroupid, f.*
	from #cycles_wr_pre f
	join #rptgrp_farmid fid
	on fid.farm_name = f.farmid
		) xx
	group by xx.reportinggroupid) x2
	on x2.reportinggroupid = x1.reportinggroupid
	

select reportinggroupid, Reporting_group_description	--, phase
, sum(prim_wt) as wtsold	-- 2014-07-03 email from Dan  no difference between mult and commercial
, sum(prim_qty) as qtysold	-- 2014-07-03 email from Dan  no difference between mult and commercial
into #w25w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @wk25 and @wk00 
  and phase in ('FIN', 'wtf')
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;
	
	
	
select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
      ,sum(cast(isnull(wean_qty,0)+.00001 as float)) Wean_qty		-- deal with zero or nulls
      ,sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) sw
      , sum(cast(isnull(wean_qty,0)+.00001 as float))/sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) gpw
into #wean
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid
join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w23 
group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
--having sum(Litters_weaned_qty) > 0 and avg(cast(wean_qty as float)/cast([Litters_weaned_qty] as float)) > 0

select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
      ,sum([Litters_farrowed_qty]) sf
into #farrow
from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid
join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w26 
group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26

select #farrow.reportinggroupid,#farrow.pg_week, #farrow.w23, #farrow.w26 
, #wean.wean_qty, #farrow.sf, #wean.wean_qty/#farrow.sf as gpw
into #wf
from #farrow 
join #wean
	on #wean.reportinggroupid = #farrow.reportinggroupid
	and #wean.pg_week = #farrow.pg_week
	and #wean.w23 = #farrow.w23
	and #wean.w26 = #farrow.w26

	
	
select lb.reportinggroupid, lb.pg_week, lb.w23
, sum(pgw.prim_qty) PQ
, sum(pgw.prim_wt) Pw
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #MktWk
FROM #lookback lb
join [dbo].[cft_SLF_ESSBASE_DATA] pgw
	on pgw.reportinggroupid = lb.reportinggroupid and pgw.pg_week = lb.pg_week
group by lb.reportinggroupid, lb.pg_week, lb.w23

select fw.reportinggroupid, lb.pg_week, lb.w23
, sum([total_sow_qty]) FI
, sum([lact_sow_days]) LD
, sum([Gest_sow_days]) GD
, sum([total_sow_days]) td
into #wrollup
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid --and fid.reportinggroupid = fw.reportinggroupid  
join  #lookback lb
	on fid.reportinggroupid = lb.reportinggroupid and fw.picyear_week = lb.w23 
group by fw.reportinggroupid, lb.pg_week, lb.w23

select lb.reportinggroupid, avg( m.pq /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) psy
, avg( m.pw /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) lbsy
into #sowyear
from  #lookback lb 
join #MktWk	m
	on m.reportinggroupid = lb.reportinggroupid and m.w23 = lb.w23 and m.hs > 0
left join #wean w
	on w.reportinggroupid = lb.reportinggroupid and w.pg_week = lb.pg_week and w.w23 =lb.w23
left join #wrollup ru
	on ru.reportinggroupid = lb.reportinggroupid and ru.pg_week = lb.pg_week and ru.w23 =lb.w23
left join #wf 
	on #wf.reportinggroupid = lb.reportinggroupid and #wf.pg_week = lb.pg_week and #wf.w23 =lb.w23 
group by lb.reportinggroupid
	
	
	


select distinct 
  @pg_week as picyearweek
, S.reportinggroupid, S.Reporting_Group_Description
--1.	Lac Feed lbs/day =  (Total Lac Feed delivered in 6 months  – Total Lac Feed transferred away in 6 months)/(Total Sow Lac Days in 6 months)
, #LSowinfo.lacfeedlbsperday as 'Llbsday'
, #LSowAvg.avgLdays as lactdays
--, #sowinfo.lacfeedlbsperday* as 'LlbsSowYear'
, ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc)  as 'LlbsSowYear'
, #GSowinfo.gesfeedlbsperday as 'Glbsday'
, #GSowAvg.avgGdays as gestdays
--, #sowinfo.gesfeedlbsperday*365 as 'GlbsSowYear'
,( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc)  as 'GlbsSowYear'
, ( ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc) + ( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc) )/2000 'Total Tons/sow/year'
, nur.nurfe
, fin.finfe
, wtf.wtffe
, ( #market.feed_qty + ( ( ( #LSowinfo.lacfeedlbsperday * #LSowAvg.avgLdays * CY.cyc) + ( #GSowinfo.gesfeedlbsperday * #GSowAvg.avgGdays * CY.cyc) ) 
/ (#sowyear.psy) ) * (w25w00.qtysold) ) 
/ (w25w00.wtsold) as [Whole Herd FE]

from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] ) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #LSowinfo
	on #LSowinfo.reportinggroupid = S.reportinggroupid
left join #LSowAvg
	on #LSowAvg.reportinggroupid = S.reportinggroupid
left join #GSowinfo
	on #GSowinfo.reportinggroupid = S.reportinggroupid
left join #GSowAvg
	on #GSowAvg.reportinggroupid = S.reportinggroupid
left join #market
	on #market.reportinggroupid = S.reportinggroupid
left join #w5123
	on #w5123.reportinggroupid = S.reportinggroupid
left join #w25w00 w25w00
	on w25w00.reportinggroupid = S.reportinggroupid
left join #w6826
	on #w6826.reportinggroupid = S.reportinggroupid
left join #cycles CY
on CY.reportinggroupid = s.reportinggroupid
left join #sowyear
on #sowyear.reportinggroupid = s.reportinggroupid
left join 
	(select es.reportinggroupid 
, case 
	  when isnull( (isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) )),0) <> 0 
	  then isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) ) else 0 end
	  +  ((50 - case when (isnull((sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ),0) ) <> 0 
					 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadOnTruck_Wt),0) + isnull(sum(DeadInYard_wt),0) + isnull(sum(Condemn_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(pigdeathTD_Wt),0) + isnull(sum(TransportDeath_Wt),0)) 
					 / (isnull( (sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty) ),0) ) 
					 else 0 end) * 0.005)  nurfe		
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.pg_week between @wk26 and @pg_week
		  and es.phase in ('nur','wtf') and es.prim_wt = 0
		  and es.transferinwp_wt > 0
		group by es.reportinggroupid) as NUR
			on nur.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid		
, case 
	  when isnull( (isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) )),0) <> 0 
	  then isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) ) else 0 end
	  +  ((50 - case when (isnull((sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ),0) ) <> 0 
					 then ((sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) )) 
					 / (isnull( ((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_wt)  - sum(moveout_qty) )) ,0) ) 
					 else 0 end) * 0.005)
	  + ( ( 270 - (case when (isnull((sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ),0) ) <> 0 
					 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadOnTruck_Wt),0) + isnull(sum(DeadInYard_wt),0) + isnull(sum(Condemn_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(pigdeathTD_Wt),0) + isnull(sum(TransportDeath_Wt),0)) 
					 / (isnull( (sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty) ),0) ) 
					 else 0 end) ) * .001) finfe
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.pg_week between @wk26 and @pg_week
		  and es.phase = 'FIN' 
		group by es.reportinggroupid) as FIN
			on fin.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid
	 , case 
	  when isnull( (isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) )),0) <> 0 
	  then isnull(sum(es.feed_qty),0) / ((sum([Prim_Wt]) + sum([Cull_Wt]) + sum([DeadOnTruck_Wt]) + sum([DeadInYard_Wt]) + sum([Condemn_Wt]) + sum(transferout_wt) + sum(pigdeathTD_wt) + sum(transportdeath_wt) + sum(transfertotailender_wt)  )
   - (sum(transferinwp_wt) + sum(transferin_wt) + sum(movein_wt)  - sum(moveout_wt) ) ) else 0 end
	  + ( ( 270 - (case when (isnull((sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty)  ),0) ) <> 0 
					 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadOnTruck_Wt),0) + isnull(sum(DeadInYard_wt),0) + isnull(sum(Condemn_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(pigdeathTD_Wt),0) + isnull(sum(TransportDeath_Wt),0)) 
					 / (isnull( (sum([Prim_qty]) + sum([Cull_qty]) + sum([DeadOnTruck_qty]) + sum([DeadInYard_qty]) + sum([Condemn_qty]) 
									+ sum(transferout_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) + sum(transfertotailender_qty) ),0) ) 
					 else 0 end) ) * .001)	  wtffe
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.pg_week between @wk26 and @pg_week
		  and es.phase = 'wtf' 
		group by es.reportinggroupid) as WTF
			on wtf.reportinggroupid = S.reportinggroupid




END






















GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_FE_all] TO PUBLIC
    AS [dbo];

