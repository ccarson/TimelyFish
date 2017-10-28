




-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_MAIN_staged_rg_smr
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_MAIN_staged_rg]
	@mg_week char(6)	
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @pg_week char(6)
set @pg_week = @mg_week

declare @startday datetime
declare @start char(6)
declare @FES_picyear_week char(6)
declare @FEE_picyear_week char(6)

-- get last date value for the selected week
select @startday = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo	-- last daydate of the selected picyear_week (market date), used to determing the date - 6 months earlier
where picyear_week = @mg_week

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo	-- picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-26,@startday)

select @FEE_picyear_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo	-- farrowing_end_picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-27,@startday) 

select @FES_picyear_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo	-- farrowing_end_picyear_week value for 6 months earlier	(start of the market interval)
where daydate = dateadd(ww,-52,@startday) 

declare @startdate datetime
declare @enddate datetime
declare @TLactDays float
declare @TGestDays float

-- get last date value for the selected week
select @enddate = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @mg_week


select @startdate = min(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@enddate)

declare @w00 char(6)			-- entered picyear_week value
	set @w00 = @mg_week
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


	
select distinct reportinggroupid, Reporting_Group_Description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where mg_week between @w51 and @w00
 
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

--select distinct reportinggroupid
--,case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
--     when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
--     else reporting_group_description
--end reporting_group_description
--, pg_week, dw23.picyear_week as w23, dw26.picyear_week as w26 
--into #lookback
--from [dbo].[cft_SLF_ESSBASE_DATA] eb (nolock) 
--join  dbo.cftDayDefinition_WithWeekInfo dw (nolock)
--	on dw.dayname = 'sunday' and dw.picyear_week = eb.pg_week
--join  dbo.cftDayDefinition_WithWeekInfo dw23 (nolock)
--	on dw23.dayname = 'sunday' and dateadd(ww,-22,dw.daydate) = dw23.daydate
--join  dbo.cftDayDefinition_WithWeekInfo dw26 (nolock)
--	on dw26.dayname = 'sunday' and dateadd(ww,-25,dw.daydate) = dw26.daydate
--where 1=1	--reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
--and pg_week between @w26 and @pg_week

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
where pg_week between @w26 and @pg_week

--declare @farmid varchar(500)

--select pcf.farm_name, reportinggroupid, reporting_group_description
--into #rptgrp_farmid
--from 
--(select distinct reportinggroupid 
--	,COALESCE(@farmid + ', ', '') + 
--	case when reporting_group_description = 'LDC' then 'C27,C28,C29,C30,C31'
--		 when reporting_group_description = 'ON' then 'C32,C33,C34,C35,C36,C37'
--		 else reporting_group_description
--	end reporting_group_description 
--from [dbo].[cft_SLF_ESSBASE_DATA]
--where pg_week between @w26 and @pg_week) rglist
--join [$(PigCHAMP)].[careglobal].[FARMS] pcf (nolock)
--	on charindex(pcf.farm_name,rglist.reporting_group_description) > 0 
	
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


--select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
--      ,sum(cast(isnull(wean_qty,0)+.00001 as float)) Wean_qty		-- deal with zero or nulls
--      ,sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) sw
--      , sum(cast(isnull(wean_qty,0)+.00001 as float))/sum(cast(isnull([Litters_weaned_qty],0)+.001 as float)) gpw
--into #wean
--from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid
--join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w23 
--group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
----having sum(Litters_weaned_qty) > 0 and avg(cast(wean_qty as float)/cast([Litters_weaned_qty] as float)) > 0

--select fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26
--      ,sum([Litters_farrowed_qty]) sf
--into #farrow
--from [dbo].[cft_SowMart_Farrow_Wean_Weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid
--join #lookback on fid.reportinggroupid = #lookback.reportinggroupid and fw.picyear_week = #lookback.w26 
--group by fid.reportinggroupid, #lookback.pg_week, #lookback.w23, #lookback.w26

--select #farrow.reportinggroupid,#farrow.pg_week, #farrow.w23, #farrow.w26 
--, #wean.wean_qty, #farrow.sf, #wean.wean_qty/#farrow.sf as gpw
--into #wf
--from #farrow 
--join #wean
--	on #wean.reportinggroupid = #farrow.reportinggroupid
--	and #wean.pg_week = #farrow.pg_week
--	and #wean.w23 = #farrow.w23
--	and #wean.w26 = #farrow.w26

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

	
	
--select lb.reportinggroupid, lb.pg_week, lb.w23
--, sum(pgw.prim_qty) PQ
--, sum(pgw.prim_wt) Pw
--, case when sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty) = 0 then null
--  else sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)
--  end  HS
--into #MktWk
--FROM #lookback lb
--join [dbo].[cft_SLF_ESSBASE_DATA] pgw
--	on pgw.reportinggroupid = lb.reportinggroupid and pgw.pg_week = lb.pg_week
--group by lb.reportinggroupid, lb.pg_week, lb.w23

select lb.reportinggroupid, lb.pg_week, lb.w23
, sum(pgw.prim_qty) PQ
, sum(pgw.prim_wt) Pw
, sum(TransferInWP_qty) + Sum(TransferIn_qty) + Sum(MoveIn_qty) - sum(moveout_qty) - sum(transferout_qty)  HS
into #MktWk
FROM #lookback lb
join [dbo].[cft_SLF_ESSBASE_DATA] pgw
	on pgw.reportinggroupid = lb.reportinggroupid and pgw.pg_week = lb.pg_week
group by lb.reportinggroupid, lb.pg_week, lb.w23




--select fw.reportinggroupid, lb.pg_week, lb.w23
--, sum([total_sow_qty]) FI
--, sum([lact_sow_days]) LD
--, sum([Gest_sow_days]) GD
--, sum([total_sow_days]) td
--into #wrollup
--from [dbo].[cft_SowMart_weekly_Rollup] fw (nolock)
--join #rptgrp_farmid fid
--	on fid.farm_name = fw.farmid --and fid.reportinggroupid = fw.reportinggroupid  
--join  #lookback lb
--	on fid.reportinggroupid = lb.reportinggroupid and fw.picyear_week = lb.w23 
--group by fw.reportinggroupid, lb.pg_week, lb.w23


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
	
	
	
	

SELECT [Reporting_Group_Description], reportinggroupid
		  ,sum(
		   [PIG_DEATH]
		  +[PIG_FEED_DELIV]
		  +[PIG_FEED_GRD_MIX]
		  +[PIG_FEED_ISSUE]
		  +[PIG_INT_WC_CHG]
		  +[PIG_MEDS_CHG]
		  +[PIG_MEDS_ISSUE]
		  +[PIG_MISC_EXP]
		  +[PIG_MOVE_IN]
		  +[PIG_MOVE_OUT]
		  +[PIG_OVR_HD_CHG]
		  +[PIG_OVR_HD_COST]
		  +[PIG_PURCHASE]
		  +[PIG_SITE_CHG]
		  +[PIG_TRANSFER_IN]
		  +[PIG_TRANSFER_OUT]
		  +[PIG_TRUCKING_CHG]
		  +[PIG_TRUCKING_IN]
		  +[PIG_VACC_CHG]
		  +[PIG_VACC_ISSUE]
		  +[PIG_VET_CHG]
		  +[REPAIR_MAINT]
		  +[SUPPLIES]
		  +[TRANSPORT_DEATH]) as totalcost
into #cost
	  FROM [dbo].[cft_SLF_ESSBASE_DATA_COSTS]
	  where mg_week between @start and @mg_week 
	  group by Reporting_Group_Description, reportinggroupid
	  
SELECT reportinggroupid, [Reporting_Group_Description], 
	 sum([Prim_Qty] + [Cull_Qty]) sold_qty
, ((sum(prim_wt) + sum(cull_wt)) / 100) mrkted_wgt_cwt
, (sum(prim_wt) + sum(cull_wt)) mrkted_wgt
,sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt) OUT_wgt 
into #amt
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where mg_week between @start and @mg_week 
group by Reporting_Group_Description, reportinggroupid

	
	
--select lb.reportinggroupid
--, avg( m.pq /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) psy
--, avg( m.pw /(( ((m.HS/#wf.GPw)/#wf.sf ) / 52 ) * (ru.fi*((ru.ld+ru.gd)/ru.td)))) lbsy
--into #sowyear
--from  #lookback lb 
--join #MktWk	m
--	on m.reportinggroupid = lb.reportinggroupid and m.w23 = lb.w23
--left join #wean w
--	on w.reportinggroupid = lb.reportinggroupid and w.pg_week = lb.pg_week and w.w23 =lb.w23
--left join #wrollup ru
--	on ru.reportinggroupid = lb.reportinggroupid and ru.pg_week = lb.pg_week and ru.w23 =lb.w23
--left join #wf 
--	on #wf.reportinggroupid = lb.reportinggroupid and #wf.pg_week = lb.pg_week and #wf.w23 =lb.w23 
--group by lb.reportinggroupid

select lb.reportinggroupid
, avg( m.pq /(( (((m.HS+.00001)/(#wf.GPw+.00001))/(#wf.sf+.00001) ) / 52 ) * (lac.lacdays+ges.gesdays))) psy
, avg( m.pw /(( (((m.HS+.00001)/(#wf.GPw+.00001))/(#wf.sf+.00001) ) / 52 ) * (lac.lacdays+ges.gesdays))) lbsy
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


select amt.reportinggroupid, amt.reporting_group_description
, SC.totalcost
, amt.mrkted_wgt_cwt as cwt
 , #sowyear.lbsy as lbs_sow_year
 , SC.TotalCost/((amt.OUT_wgt+.00001)/100) as cost_per_cwt  --TotCost_per_cwtL
from  (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] ) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #amt amt
	on amt.reportinggroupid = S.reportinggroupid 
left join #cost SC
	on SC.reportinggroupid = S.reportinggroupid 
left join #sowyear	 
	on #sowyear.reportinggroupid = S.reportinggroupid
where amt.reporting_group_description is not null
and  #sowyear.lbsy is not null
and amt.reportinggroupid <> 78
order by cost_per_cwt desc



END







GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_MAIN_staged_rg] TO [CorpReports]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_MAIN_staged_rg] TO [db_sp_exec]
    AS [dbo];

