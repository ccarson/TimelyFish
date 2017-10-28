









-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_FE_staged
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_FE_staged_rg_20140528]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startdate datetime
declare @enddate datetime
declare @pyweek_start char(6)
declare @fstartdate datetime
declare @fenddate datetime
declare @fpyweek_start char(6)
declare @fpyweek_end char(6)
declare @wk23 char(6), @wk26 char(6)
declare @pf1 varchar(5)
declare @pf2 varchar(5)
declare @pf3 varchar(5)
declare @pf4 varchar(5)
declare @pf5 varchar(5)
declare @pf6 varchar(5)
declare @pf7 varchar(5)

set @pf1 = null
set @pf2 = null
set @pf3 = null
set @pf4 = null
set @pf5 = null
set @pf6 = null
set @pf7 = null


declare @pos int, @parmcnt int
set @pos = 1
set @parmcnt = 1

-- marketing pig time frames
-- get datetime value for last day of the market interval
select @enddate = max(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @mg_week
-- get picyear_week value for first day of the market interval
select @pyweek_start = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-26,@enddate)
set @wk26 = @pyweek_start
-- get datetime value for first day of the interval
select @startdate = min(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @pyweek_start

-- farrowing time frames
-- get datetime value for last day of the farrow interval
select @fpyweek_start = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-27,@startdate)		--@startdate is the first day of the market interval, becomes first week of farrow interval
select @fstartdate = min(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @fpyweek_start
select @fpyweek_end = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-27,@enddate)
select @fenddate = max(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @fpyweek_end


declare @wk42 char(6), @wk48 char(6), @wk17 char(6), @wk51 char(6), @wk68 char(6), @wk49 char(6)
select @wk23 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-23,@enddate)
select @wk68 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-68,@enddate)
select @wk42 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-42,@enddate)
select @wk48 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-48,@enddate)
select @wk49 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-49,@enddate)
select @wk17 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-17,@enddate)
select @wk51 = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(ww,-51,@enddate)





--select @pos, @parmcnt, @reportinggroupid_list, 'begin'

while (charindex(',',@reportinggroupid_list) > 0) or ( (charindex(',',@reportinggroupid_list) = 0) and (len(@reportinggroupid_list) >= 2) or @parmcnt <= 4)
begin

if (charindex(',',@reportinggroupid_list) = 0) GOTO LAST_ONLY

select @pos = charindex(',',@reportinggroupid_list)

if (@parmcnt = 1)
	begin
		select @pf1 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 2)
	begin
		select @pf2 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 3)
	begin
		select @pf3 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
	
if (@parmcnt = 4)
	begin
		select @pf4 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end
if (@parmcnt = 5)
	begin
		select @pf5 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end

	
if (@parmcnt = 6)
	begin
		select @pf6 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end

	
if (@parmcnt = 7)
	begin
		select @pf7 = substring(@reportinggroupid_list,1,@pos - 1)
		select @reportinggroupid_list = substring(@reportinggroupid_list,@pos+1,30)
	end

set @parmcnt = @parmcnt + 1
--select 'bottom of loop', @parmcnt

end

BYPASS:
	GOTO SKIPIT

LAST_ONLY:

--select @pos, @parmcnt, @reportinggroupid_list, 'last only'

if @parmcnt = 1  set @pf1 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 2  set @pf2 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 3  set @pf3 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 4  set @pf4 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 5  set @pf5 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 6  set @pf6 = substring(@reportinggroupid_list,1,4)
else if @parmcnt = 7  set @pf7 = substring(@reportinggroupid_list,1,4)

SKIPIT:


select distinct reportinggroupid, Reporting_Group_Description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where mg_week between @pyweek_start and @mg_week	-- 26 weeks ago    and inputted week
 and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
 
 -- the slf kpi report requests a picyear_week value.   this represents the last picyear_week value of a 6 month interval (a market pig's sold interval)
-- sow farrowing and weaning events that create the pigs marketed occur in a prior 6 month interval
-- this also applies to the feed consumed by the sows.



--         Sow Days,  Sow Counts,   avg qty lact days,   avg Gest days
--select reportinggroupid
--, sum(gest_sow_days) Gdays, sum(lact_sow_days) Ldays, avg(gest_sow_qty) avgGsowcnt, avg(lact_sow_qty) avgLsowcnt
--, sum(lact_feed_lbs) lact_feed_lbs
--, sum(gest_feed_lbs) gest_feed_lbs
--, sum(cast(lact_feed_lbs as float))/sum(cast(lact_sow_days as float)) as lacfeedlbsperday
--, sum(cast(gest_feed_lbs as float))/( sum(cast(gest_sow_days as float)) + sum(cast(nonprod_sow_days as float)) ) as gesfeedlbsperday
--into #Sowinfo
--from [dbo].[cft_SowMart_weekly_Rollup]
--where picyear_week between  @pyweek_start and @mg_week		
--  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--group by reportinggroupid
-- lactating Sow Info
select reportinggroupid
, sum(lact_sow_days) Ldays, avg(lact_sow_qty) avgLsowcnt
, sum(lact_feed_lbs) lact_feed_lbs
, sum(cast(lact_feed_lbs as float))/sum(cast(lact_sow_days as float)) as lacfeedlbsperday
into #LSowinfo
from [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk51 and @wk23		
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid

select reportinggroupid, avg(cast(lact_days_qty as float)) avgLdays
into #LSowAvg
from  [dbo].[cft_SowMart_Detail_data] 
where farrow_picyear_week between @wk51 and @wk23	
  and  reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid


-- Gestating Sow Info
select reportinggroupid
, sum(gest_sow_days) Gdays, avg(gest_sow_qty) avgGsowcnt
, sum(gest_feed_lbs) gest_feed_lbs
--, sum(cast(gest_feed_lbs as float))/( sum(cast(gest_sow_days as float))  ) as gesfeedlbsperday
, sum(cast(gest_feed_lbs as float))/( sum(cast(gest_sow_days as float)) + sum(cast(nonprod_sow_days as float)) ) as gesfeedlbsperday
into #GSowinfo
from [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk68 and @wk26		
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid


select reportinggroupid, avg(cast(gest_days_qty as float)) avgGdays
into #GSowAvg
from  [dbo].[cft_SowMart_Detail_data] 
where farrow_picyear_week between @wk68 and @wk26	
  and  reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid


 
-- market hog information     nursery,fin,wtf feed consumed, pig lbs sold   ??  include dead weight  too??
select es.reportinggroupid, sum(es.feed_qty) feed_qty
--, sum(es.[Prim_Wt]) + sum(es.[Cull_Wt]) + sum(es.[DeadOnTruck_Wt]) + sum(es.[DeadInYard_Wt]) + sum(es.[Condemn_Wt])
, sum(es.[Prim_Wt]) + sum(es.[Cull_Wt]) + sum(es.[DeadOnTruck_Wt]) + sum(es.[DeadInYard_Wt]) + sum(es.[Condemn_Wt]) 
  + sum(es.moveout_wt) + sum(es.transferout_wt) + sum(es.pigdeathTD_wt) + sum(es.transportdeath_wt) + sum(es.transfertotailender_wt)    
as mtkwgt
into #market
from  dbo.cft_slf_essbase_data es (nolock)
--inner join #pf_list
--on #pf_list.reportinggroupid = es.reportinggroupid
where es.mg_week between @pyweek_start and @mg_week
  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by es.reportinggroupid




select reportinggroupid, sum(feed_qty) Finfeed
into #w4200
from[dbo].[cft_slf_essbase_data]  flow (nolock)
where  flow.mg_week between @wk42 and @mg_week
  and  flow.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  and  flow.phase = 'FIN'
group by reportinggroupid

select reportinggroupid, sum(feed_qty) nurfeed
into #w4817
from[dbo].[cft_slf_essbase_data]  flow (nolock)
where  flow.mg_week between @wk48 and @wk17
  and  flow.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  and  flow.phase = 'nur'
group by reportinggroupid

select reportinggroupid, sum(feed_qty) wtffeed
into #w4800
from[dbo].[cft_slf_essbase_data]  flow (nolock)
where  flow.mg_week between @wk48 and @mg_week
  and  flow.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  and  flow.phase = 'wtf'
group by reportinggroupid

--select reportinggroupid, sum(feed_qty) wtffeed
--into #w4200
--from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
--where  flow.picyear_week between @wk42 and @mg_week
--  and  flow.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  and  flow.phase = 'wtf'
--group by reportinggroupid

select reportinggroupid
, sum(lact_feed_lbs) lact_feed_lbs
into #w5123
from [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk51 and @wk23
  and  reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid

select reportinggroupid
, sum(gest_feed_lbs) gest_feed_lbs
into #w6826
from [dbo].[cft_SowMart_weekly_Rollup]
where picyear_week between  @wk68 and @wk26
  and  reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid


select x1.reportinggroupid, x1.avgldays, x1.avggday, x2.nondays
,  x1.avgldays+x1.avggday+x2.nondays Tdays
, 365/(x1.avgldays+x1.avggday+x2.nondays) cyc
into #cycles
from 
(select reportinggroupid, avg(cast(lact_days_qty as float)) avgLdays, avg(cast(gest_days_qty as float)) avgGday
from  [dbo].[cft_SowMart_Detail_data] 
where farrow_picyear_week between @wk51 and @mg_week
  and  reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by reportinggroupid) x1
join  
(SELECT reportinggroupid, sum(nonprod_sow_days)/sum(nonprod_sow_qty) nondays
  FROM [dbo].[cft_SowMart_weekly_Rollup]
  where reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  and picyear_week between @wk51 and @mg_week
 group by reportinggroupid) x2
	on x2.reportinggroupid = x1.reportinggroupid





--reportinggroupid
--Reporting_Group_Description
--Llbsday
--	1.	Lac Feed lbs/day =  (Total Lac Feed delivered in 6 months  – Total Lac Feed transferred away in 6 months)/(Total Sow Lac Days in 6 months)
--lactdays
--	2.	Lac Days/Farrow Event =   Ave(Wean date – Farrow date) in 6 months
--avglactdays
--Llbssowyear
--	3.	Lac Feed lbs/sow/year = (Total Lac Feed in 1 year)/(Total Sow Lac Days in year/365)   
--Glbsday
--	4.	Gest Feed lbs/day =  (Total Gest Feed delivered in 6 months  – Total Gest Feed transferred away in 6 months)/(Total Sow Gest Days in 6 months)
--gestdays
--	5.	Gest Days/Farrow Event =  Ave(Farrow date – 1st Service date) in 6 months
--GlbsSowYear
--	6.	Gest Feed lbs/sow/year = (Total Gest Feed in 1 year)/(Total Sow Gest Days in year/365)   
--Total_Tons_sow_year
--	7.	Total tons/sow/year = [(Total Lac Feed in 1 yr) + (Total Gest Feed in 1 yr)]/(Sow Inventory + Gilt Inventory)
--nurfe
--finfe
--wtffe
--whole_herd_FE
-- ( sum(Finfeedw42-00)*(26/43) ) + ( sum(NURfeedw48-16)*(26/33) ) + ( sum(Lacfeedw51-22)*(26/30) ) + ( sum(gestfeedw67-25)*(26/42) )
-- divided by
-- (sum(prim_wt) + sum(cull_wt) + other wts  week 25 - 00 )
--target 3.5 - 3.8 lbs

select distinct S.reportinggroupid, S.Reporting_Group_Description
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
--, ( (isnull(#w4200.finfeed,0) * (26.0/43.0)) + (isnull(#w4817.nurfeed*(26.0/32.0),0)) + ( isnull(#w4800.wtffeed*(26.0/49.0),0) )+ (#w5123.lact_feed_lbs * (26.0/29.0)) +  (#w6826.gest_feed_lbs * (26.0/43.0)) )  / #market.mtkwgt as [Whole Herd FE]	
, ( #market.feed_qty + (#w5123.lact_feed_lbs * (26.0/29.0)) +  (#w6826.gest_feed_lbs * (26.0/43.0)) )  / #market.mtkwgt as [Whole Herd FE]	
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
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
left join #w4200
	on #w4200.reportinggroupid = S.reportinggroupid
left join #w4800
	on #w4800.reportinggroupid = S.reportinggroupid
left join #w4817
	on #w4817.reportinggroupid = S.reportinggroupid
left join #w5123
	on #w5123.reportinggroupid = S.reportinggroupid
left join #w6826
	on #w6826.reportinggroupid = S.reportinggroupid
left join #cycles CY
on CY.reportinggroupid = s.reportinggroupid
left join 
	(select es.reportinggroupid
	  , sum(transferout_wt) transferout_wt, sum(transferinwp_wt) transferinwp_wt
	  , sum(es.feed_qty) /
	  case when ( sum(transferout_wt) - sum(transferinwp_wt) ) = 0 then null
	  else  ( sum(transferout_wt) - sum(transferinwp_wt) )
	  end nurfe	
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.mg_week between @pyweek_start and @mg_week
		  and es.phase in ('nur','wtf') and es.prim_wt = 0
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
		group by es.reportinggroupid) as NUR
			on nur.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid
	  , ( sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) ) out_wgt
	  , ( sum(transferinWP_wt) + sum(transferin_wt) + sum(movein_wt) - sum(moveout_wt) - sum(pigdeathTD_wt) - sum(transportdeath_wt) - sum(transferout_wt) - sum(transfertotailender_wt) )  in_wgt
	  ,sum(es.feed_qty) / ( ( sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) ) - ( sum(transferinWP_wt) + sum(transferin_wt) + sum(movein_wt) - sum(moveout_wt) - sum(pigdeathTD_wt) - sum(transportdeath_wt) - sum(transferout_wt) - sum(transfertotailender_wt) ) ) finfe
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.mg_week between @pyweek_start and @mg_week
		  and es.phase = 'FIN' 
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
		group by es.reportinggroupid) as FIN
			on fin.reportinggroupid = S.reportinggroupid
left join 
	(select es.reportinggroupid
	  , ( sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) ) out_wgt
	  , ( sum(transferin_wt) + sum(movein_wt) - sum(moveout_wt) - sum(pigdeathTD_wt) - sum(transportdeath_wt) - sum(transferout_wt) - sum(transfertotailender_wt) )  in_wgt
	  , sum(es.feed_qty) / ( ( sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) ) - ( sum(transferinWP_wt) + sum(transferin_wt) + sum(movein_wt) - sum(moveout_wt) - sum(pigdeathTD_wt) - sum(transportdeath_wt) - sum(transferout_wt) - sum(transfertotailender_wt) ) ) wtffe
		from  dbo.cft_slf_essbase_data es (nolock)
		where es.mg_week between @pyweek_start and @mg_week
		  and es.phase = 'wtf' 
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
		group by es.reportinggroupid) as WTF
			on wtf.reportinggroupid = S.reportinggroupid




END

--left join 
--(SELECT  reportinggroupid, phase
--,         case
--			  when Phase = 'NUR'
----				    then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
--					then case when isnull(sum(WeightGained),0) <> 0 then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0 end
----					+  ((50 - AverageOut_Wt) * 0.005)
--					+  ((50 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0 then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
--		end NURFE
--from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
--where  flow.picyear_week between @pyweek_start and @mg_week
--  and  flow.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  and  flow.phase = 'NUR'
--group by reportinggroupid, phase ) NUR
--	on nur.reportinggroupid = #pf_list.reportinggroupid
--left join
--(SELECT  reportinggroupid, phase
--,         case when Phase = 'FIN'
----				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
--				then case when isnull(sum(WeightGained),0) <> 0	then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end 
--				+ ((50 - case when isnull(sum(TransferIn_Qty),0) <> 0 then isnull(sum(TransferIn_Wt),0) / sum(TransferIn_Qty) else 0 end) * 0.005) 
--				+ ((270 - case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
--				then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
--		end FINFE
--from[dbo].[cft_RPT_PIG_MASTER_GROUP_DW]  flow (nolock)
--where  flow.picyear_week between @pyweek_start and @mg_week
--  and  flow.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--  and  flow.phase = 'FIN'
--group by reportinggroupid, phase ) FIN
--	on fin.reportinggroupid = #pf_list.reportinggroupid
--left join
--(SELECT  reportinggroupid, phase
--,         case when Phase = 'WTF'
----				then FeedToGain + ((270 - AverageOut_Wt) * 0.005)
--				then case when isnull(sum(WeightGained),0) <> 0	then isnull(sum(Feed_Qty),0) / sum(WeightGained) else 0	end
----				+ ((270 - AverageOut_Wt) * 0.005)
--				+ ((270 -case when (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) <> 0
--				then (isnull(sum(Prim_Wt),0) + isnull(sum(Cull_Wt),0) + isnull(sum(DeadPigsToPacker_Wt),0) + isnull(sum(TransferToTailender_Wt),0) + isnull(sum(TransferOut_Wt),0) + isnull(sum(TransportDeath_Wt),0)) / (isnull(sum(TotalHeadProduced),0) + isnull(sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
--            end as WTFFE














