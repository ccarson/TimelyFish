









-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Mkting
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_Mkting_all]
	@pg_week char(6)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;


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



select distinct reportinggroupid, Reporting_group_description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @start and @pg_week

 
 
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
into #lookback
from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
where pg_week between @w26 and @pg_week

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
where pg_week between @w26 and @pg_week) rglist
join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 





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
having (sum(transferinwp_qty) + sum(transferin_qty) + sum(movein_qty)) > 0
and (sum(prim_qty) + sum(cull_qty) ) > 0
order by Reporting_group_description


select reportinggroupid, Reporting_group_description	--, phase
, @w51 starting_picyear_week, @w00 ending_picyear_week
, sum(prim_wt) as wtsold	-- 2014-07-03 email from Dan  no difference between mult and commercial
, sum(prim_qty) as qtysold	-- 2014-07-03 email from Dan  no difference between mult and commercial
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #w51w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where pg_week between @w51 and @w00 
  and phase in ('FIN', 'wtf')
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
left join #wrollup ru
	on ru.reportinggroupid = lb.reportinggroupid and ru.pg_week = lb.pg_week and ru.w23 =lb.w23
left join #wf 
	on #wf.reportinggroupid = lb.reportinggroupid and #wf.pg_week = lb.pg_week and #wf.w23 =lb.w23 
group by lb.reportinggroupid





  select @pg_week,S.reportinggroupid, S.Reporting_group_description
  , mkt.primpct pctprim
  , '' pctresales
  , mkt.cullpct pctcull
  , mkt.wgt_produced/mkt.head_produced avg_mkt_wgt
 , #sowyear.psy as [pigs mkt per inv sow per year]
  , #sowyear.lbsy as [LBS mkt per inv sow per year]
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 	) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #mkt mkt	-- 26 weeks    
	on mkt.reportinggroupid = S.reportinggroupid
left join #sowyear	 
	on #sowyear.reportinggroupid = S.reportinggroupid



END































