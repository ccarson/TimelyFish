﻿







-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Mkting
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_mkting_rg]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @pg_week char(6)
set @pg_week = @mg_week

declare @startdate datetime
declare @enddate datetime
declare @start char(6)
declare @FES_picyear_week char(6)
declare @FEE_picyear_week char(6)
declare @TLactDays float
declare @TGestDays float

-- get last date value for the selected week
select @enddate = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)

select @startdate = min(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)
select @FEE_picyear_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo	-- farrowing_end_picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-27,@enddate) 

select @FES_picyear_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo	-- farrowing_end_picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-52,@enddate) 

declare @w00 char(6)			-- entered picyear_week value
	set @w00 = @pg_week
declare @w23 char(6)			-- prior 22h week
	select @w23= picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-23,@enddate)
declare @w26 char(6)
	select @w26 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-26,@enddate)
declare @w51 char(6)
	select @w51 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-51,@enddate)
declare @w74 char(6)
	select @w74 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-74,@enddate)
declare @w77 char(6)
	select @w77 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-77,@enddate)
declare @w94 char(6)
	select @w94 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-94,@enddate)

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


select distinct reportinggroupid, Reporting_group_description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @start and @pg_week
 and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
 
 
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
--  

select distinct reportinggroupid
,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
     else reporting_group_description
end reporting_group_description
, pg_week, dw23.picyear_week as w23, dw26.picyear_week as w26 
, dw25.picyear_week as w25, dw42.picyear_week as w42
into #lookback
from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw25 (nolock)
	on dw25.dayname = 'sunday' and dateadd(ww,-24,dw.daydate) = dw25.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw42 (nolock)
	on dw42.dayname = 'sunday' and dateadd(ww,-41,dw.daydate) = dw42.daydate
where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
and pg_week between @w26 and @pg_week



declare @farmid varchar(500)

select distinct pcf.farm_name, reportinggroupid, reporting_group_description
into #rptgrp_farmid
from 
(select distinct reportinggroupid 
	,COALESCE(@farmid + ', ', '') + 
	case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
		 when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
		 else reporting_group_description
	end reporting_group_description 
from [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @w26 and @pg_week) rglist
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 
where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)




select reportinggroupid, Reporting_group_description	--, phase
, @start starting_picyear_week, @pg_week ending_picyear_week
  , sum(deadontruck_qty) + sum(deadinyard_qty)+ sum(condemn_qty) dotdiyc
  , sum(deadontruck_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as dotpct
  , sum(deadinyard_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as diypct
  , sum(condemn_qty)/(sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty))*100 as compct
  , sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
  --, sum(prim_qty)
  --/((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) 
  --- (sum(moveout_qty) + sum(transferout_qty) + SUM(transfertotailender_qty)+sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) )))*100 as primpct	-- per marketed pig
  
  , sum(prim_qty)  / (sum(prim_qty) + sum(cull_qty) )*100 as primpct	-- per marketed pig
  , sum(cull_qty)  / (sum(prim_qty) + sum(cull_qty) )*100 as cullpct	-- per marketed pig
  
  
  --, sum(cull_qty) /((sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty) 
  --- (sum(moveout_qty) + sum(transferout_qty) + SUM(transfertotailender_qty)+sum(pigdeath_qty) + sum(pigdeathTD_qty) + sum(transportdeath_qty) )))*100 as cullpct	-- per marketed pig 
  --, sum(prim_wt) + sum(cull_wt) as wtsold
  --, sum(prim_qty) + sum(cull_qty) as qtysold
  , sum(prim_wt) + sum(cull_wt) + sum(deadontruck_wt) + sum(deadinyard_wt) + sum(condemn_wt) as wgt_produced
  , sum(prim_qty) + sum(cull_qty) + sum(deadontruck_qty) + sum(deadinyard_qty) + sum(condemn_qty) as head_produced
into #mkt
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @start and @pg_week
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description


select reportinggroupid, Reporting_group_description	--, phase
, @w51 starting_picyear_week, @w00 ending_picyear_week
, sum(prim_wt) as wtsold	-- 2014-07-03 email from Dan  no difference between mult and commercial
, sum(prim_qty) as qtysold	-- 2014-07-03 email from Dan  no difference between mult and commercial
--, case
--	when patindex('%m%',reporting_group_description) > 0 then sum(prim_wt) + sum(transferout_wt)
--	else sum(prim_wt)  
--  end as wtsold
--, case
--	when patindex('%m%',reporting_group_description) > 0 then sum(prim_qty) + sum(transferout_qty)
--	else sum(prim_qty)  
--  end as qtysold
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #w51w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @w51 and @w00 
  and phase in ('FIN', 'wtf')
  and reportinggroupid  in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;


select fid.reportinggroupid, sum([Lact_sow_Days]) Lact_sow_Days
into #Ldays
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid
where fw.picyear_week between @w77 and @w23
group by fid.reportinggroupid


select fid.reportinggroupid, sum([gest_sow_Days]) gest_sow_Days
into #Gdays
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid
where fw.picyear_week between @w94 and @w26 
group by fid.reportinggroupid
	


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

select fid.reportinggroupid, lb_lac.pg_week, fw.picyear_week
, sum(fw.lact_sow_qty) lacdays
into #sum_farm_lac
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid 
join  #lookback lb_lac
	on fid.reportinggroupid = lb_lac.reportinggroupid and fw.picyear_week between lb_lac.w25 and lb_lac.w23 
group by fid.reportinggroupid, lb_lac.pg_week, fw.picyear_week

select fid.reportinggroupid, lb_ges.pg_week, fw.picyear_week
, sum(fw.gest_sow_qty) gesdays	-- chg
into #sum_farm_ges
from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
join #rptgrp_farmid fid
	on fid.farm_name = fw.farmid 
join  #lookback lb_ges
	on fid.reportinggroupid = lb_ges.reportinggroupid and fw.picyear_week between lb_ges.w42 and lb_ges.w26
group by fid.reportinggroupid, lb_ges.pg_week, fw.picyear_week

select reportinggroupid, pg_week
, avg(lacdays) lacdays	-- chg
into #wrollup_lac
from #sum_farm_lac 
group by reportinggroupid, pg_week

select reportinggroupid, pg_week
, avg(gesdays) gesdays	-- chg
into #wrollup_ges
from #sum_farm_ges 
group by reportinggroupid, pg_week



--select fw.reportinggroupid, lb_lac.pg_week
--, (sum(fw.lact_sow_days)/21) lacdays
--into #wrollup_lac
--from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid 
--join  #lookback lb_lac
--	on fid.reportinggroupid = lb_lac.reportinggroupid and fw.picyear_week between lb_lac.w25 and lb_lac.w23 
--group by fw.reportinggroupid, lb_lac.pg_week

--select fw.reportinggroupid, lb_ges.pg_week
--, (sum(fw.gest_sow_days)/119) gesdays
--into #wrollup_ges
--from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid 
--join  #lookback lb_ges
--	on fid.reportinggroupid = lb_ges.reportinggroupid and fw.picyear_week between lb_ges.w42 and lb_ges.w26
--group by fw.reportinggroupid, lb_ges.pg_week




select lb.reportinggroupid
--, avg( m.pq /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) psy
--, avg( m.pw /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) lbsy
, avg( m.pq /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (lac.lacdays+ges.gesdays))) psy
, avg( m.pw /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (lac.lacdays+ges.gesdays))) lbsy
into #sowyear
from  #lookback lb 
join #MktWk	m
	on m.reportinggroupid = lb.reportinggroupid and m.w23 = lb.w23
left join #wrollup_lac lac
	on lac.reportinggroupid = lb.reportinggroupid and lac.pg_week = lb.pg_week
left join #wrollup_ges ges
	on ges.reportinggroupid = lb.reportinggroupid and ges.pg_week = lb.pg_week
left join #wf 
	on #wf.reportinggroupid = lb.reportinggroupid and #wf.pg_week = lb.pg_week
group by lb.reportinggroupid





  select S.reportinggroupid, S.Reporting_group_description
  , mkt.primpct pctprim
  , '' pctresales
  , mkt.cullpct pctcull
  , mkt.wgt_produced/mkt.head_produced avg_mkt_wgt
 --, (w51w00.wtsold)/ ( ((w51w00.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * (#ldays.lday385 + #gdays.gday483) ) as [LBS mkt per inv sow per year]
 --, (w51w00.qtysold)/ ( ((w51w00.HS/#ea.gpw_per_sowwean)/#EA.litters_farrowed_qty) * (#ldays.lday385 + #gdays.gday483) ) as [pigs mkt per inv sow per year]
 --, avg( (w51w00.wtsold)/ ) as [LBS mkt per inv sow per year]
 /*Avg(Pqty/ ( ( ( (HSlbck / Average(wp23) ) / Sum(ws23) ) / 52) * ( (sows23) * ( ( Lact23 + Gest23 ) / sowdays23 ) ) ) ) as Pigs/Sow/Yr
 */
 , #sowyear.psy as [pigs mkt per inv sow per year]
  , #sowyear.lbsy as [LBS mkt per inv sow per year]
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #mkt mkt	-- 26 weeks    
	on mkt.reportinggroupid = S.reportinggroupid
--left join #w51w00 w51w00
--	on w51w00.reportinggroupid = S.reportinggroupid
--left join #Ldays	-- weeks 77 - 23
--	on #Ldays.reportinggroupid = S.reportinggroupid
--left join #Gdays	-- weeks 94 - 26
--	on #Gdays.reportinggroupid = S.reportinggroupid
left join #sowyear	 
	on #sowyear.reportinggroupid = S.reportinggroupid



END





























