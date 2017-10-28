









-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_ADG
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_MAIN_staged_rg_20140528]
	@mg_week char(6)	
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

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
declare @w77 char(6)
	select @w77 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-77,@enddate)
declare @w94 char(6)
	select @w94 = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
	where daydate = dateadd(ww,-94,@enddate)

-- build a temp table with (reportinggroupid, picyear_week marketed week, picyear_week - 6 months farrowed week, sowdays/182 as sowinventory) 
--for the 6 month interval before the 6 months interval selected (sows farrowed 6 months before marketed)
--create table #Sowinv
--(
--  reportinggroupid int not null
--, Sowqty float null
--)


--insert into #Sowinv
--select pf.reportinggroupid, sum(total_sow_days)/182.5 as sowqty
--from [dbo].[cft_SowMart_weekly_Rollup] sw
--inner join [$(PigCHAMP)].[careglobal].[FARMS] f (nolock)
--	on f.farm_name = sw.farmid
--inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_FARM] pff (nolock)
--	on pff.contactid = cast(f.farm_number as int)
--inner join [CFApp_PigManagement].[dbo].[cft_PIG_FLOW] pf (nolock)
--	on pf.pigflowid = pff.pigflowid
--where sw.picyear_week between  @FES_picyear_week and @FEE_picyear_week
--group by pf.reportinggroupid



	
-- build a temp table with (reportinggroupid, picyear_week, marketed_weight_cwt, totcost)
--create table #sowcost
--(
--  reportinggroupid int not null
--, Reporting_group_description varchar(100) not null
--, cost_per_cwt float not null
--, totalcost float not null
--, mrkted_wgt int not null
--, mrkted_wgt_cwt float not null
--)

--insert into #sowcost
--select cost.reportinggroupid,cost.Reporting_group_description, totalcost/mrkted_wgt_cwt as cost_per_cwt, totalcost, mrkted_wgt, mrkted_wgt_cwt
--from 
--(  SELECT [reportinggroupid]	
--      ,[Reporting_group_description]	
--      ,SUM([FEED_ISSUE]) as [FEED_ISSUE]
--      ,SUM([FREIGHT]) as [FREIGHT]
--      ,SUM([MISC_JOB_CHARGES]) as [MISC_JOB_CHARGES]
--      ,SUM([OTHER_REVENUE]) as [OTHER_REVENUE]
--      ,SUM([PIG_BASE_DOLLARS]) as [PIG_BASE_DOLLARS]
--      ,SUM([PIG_DEATH]) as [PIG_DEATH]
--      ,SUM([PIG_FEED_DELIV]) as [PIG_FEED_DELIV]
--      ,SUM([PIG_FEED_GRD_MIX]) as [PIG_FEED_GRD_MIX]
--      ,SUM([PIG_FEED_ISSUE]) as [PIG_FEED_ISSUE]
--      ,SUM([PIG_GRADE_PREM]) as [PIG_GRADE_PREM]
--      ,SUM([PIG_INT_WC_CHG]) as [PIG_INT_WC_CHG]
--      ,SUM([PIG_MEDS_CHG]) as [PIG_MEDS_CHG]
--      ,SUM([PIG_MEDS_ISSUE]) as [PIG_MEDS_ISSUE]
--      ,SUM([PIG_MISC_EXP]) as [PIG_MISC_EXP]
--      ,SUM([PIG_MKT_TRUCKING]) as [PIG_MKT_TRUCKING]
--      ,SUM([PIG_MOVE_IN]) as [PIG_MOVE_IN]
--      ,SUM([PIG_MOVE_OUT]) as [PIG_MOVE_OUT]
--      ,SUM([PIG_OVR_HD_CHG]) as [PIG_OVR_HD_CHG]
--      ,SUM([PIG_OVR_HD_COST]) as [PIG_OVR_HD_COST]
--      ,SUM([PIG_PURCHASE]) as [PIG_PURCHASE]
--      ,SUM([PIG_SALE]) as [PIG_SALE]
--      ,SUM([PIG_SALE_DED_OTR]) as [PIG_SALE_DED_OTR]
--      ,SUM([PIG_SITE_CHG]) as [PIG_SITE_CHG]
--      ,SUM([PIG_SORT_LOSS]) as [PIG_SORT_LOSS]
--      ,SUM([PIG_TRANSFER_IN]) as [PIG_TRANSFER_IN]
--      ,SUM([PIG_TRANSFER_OUT]) as [PIG_TRANSFER_OUT]
--      ,SUM([PIG_TRUCKING_CHG]) as [PIG_TRUCKING_CHG]
--      ,SUM([PIG_TRUCKING_IN]) as [PIG_TRUCKING_IN]
--      ,SUM([PIG_VACC_CHG]) as [PIG_VACC_CHG]
--      ,SUM([PIG_VACC_ISSUE]) as [PIG_VACC_ISSUE]
--      ,SUM([PIG_VET_CHG]) as [PIG_VET_CHG]
--      ,SUM([REPAIR_MAINT]) as [REPAIR_MAINT]
--      ,SUM([REPAIR_PARTS]) as [REPAIR_PARTS]
--      ,SUM([SITE_COST_ACCUM]) as [SITE_COST_ACCUM]
--      ,SUM([SUPPLIES]) as [SUPPLIES]
--      ,SUM([TRANSPORT_DEATH]) as [TRANSPORT_DEATH]
--      ,sum([FEED_ISSUE]+ [FREIGHT] + [MISC_JOB_CHARGES]+ 
--			+ [PIG_DEATH]
--            + [PIG_FEED_DELIV] + [PIG_FEED_GRD_MIX] + [PIG_FEED_ISSUE] 
--			+ [PIG_INT_WC_CHG]+ [PIG_MEDS_CHG]
--            + [PIG_MEDS_ISSUE] + [PIG_MISC_EXP] + [PIG_MKT_TRUCKING] + [PIG_MOVE_IN] + [PIG_MOVE_OUT]+ [PIG_OVR_HD_CHG] 
--            + [PIG_OVR_HD_COST] + [PIG_PURCHASE] 
--			+  [PIG_SITE_CHG] 
--			+ [PIG_TRANSFER_IN] + [PIG_TRANSFER_OUT] + [PIG_TRUCKING_CHG]+ [PIG_TRUCKING_IN] + [PIG_VACC_CHG] + [PIG_VACC_ISSUE] 
--			+ [PIG_VET_CHG] + [REPAIR_MAINT] + [REPAIR_PARTS] + [SITE_COST_ACCUM] + [SUPPLIES] + [TRANSPORT_DEATH] ) totalcost

--  FROM [dbo].[cft_SLF_ESSBASE_DATA_costs] (nolock) 
--  where mg_week between @start and @mg_week
--  group by reportinggroupid ,reporting_group_description) cost
  
--  left join 
  
--  ( select reportinggroupid, ((sum(prim_wt) + sum(cull_wt)) / 100) mrkted_wgt_cwt, (sum(prim_wt) + sum(cull_wt)) mrkted_wgt
--    from cft_slf_essbase_data d
--    where mg_week between @start and @mg_week
--    group by reportinggroupid ) wgt
--		on wgt.reportinggroupid = cost.reportinggroupid
	


------------------------------------------------------------------------------------
select reportinggroupid, Reporting_group_description	--, phase
, @w51 starting_picyear_week, @w00 ending_picyear_week
, sum(prim_wt) + sum(cull_wt) as wtsold
, sum(prim_qty) + sum(cull_qty) as qtysold
into #w51w00
FROM [dbo].[cft_SLF_ESSBASE_DATA] 
where mg_week between @w51 and @w00 
  and phase in ('FIN', 'wtf')
  group by reportinggroupid, Reporting_group_description	--, phase
order by Reporting_group_description;

SELECT [Reporting_Group_Description], reportinggroupid
		  ,sum([FEED_ISSUE] + [FREIGHT]+[MISC_JOB_CHARGES]
		  +[PIG_DEATH]
		  +[PIG_FEED_DELIV]
		  +[PIG_FEED_GRD_MIX]
		  +[PIG_FEED_ISSUE]
	 --     +[PIG_GRADE_PREM]
		  +[PIG_INT_WC_CHG]
		  +[PIG_MEDS_CHG]
		  +[PIG_MEDS_ISSUE]
		  +[PIG_MISC_EXP]
	 --     +[PIG_MKT_TRUCKING]	not a cost but a revenue expense
		  +[PIG_MOVE_IN]
		  +[PIG_MOVE_OUT]
		  +[PIG_OVR_HD_CHG]
		  +[PIG_OVR_HD_COST]
		  +[PIG_PURCHASE]
	  --    +[PIG_SALE]
	  --    +[PIG_SALE_DED_OTR]
		  +[PIG_SITE_CHG]
	  --    +[PIG_SORT_LOSS]
		  +[PIG_TRANSFER_IN]
		  +[PIG_TRANSFER_OUT]
		  +[PIG_TRUCKING_CHG]
		  +[PIG_TRUCKING_IN]
		  +[PIG_VACC_CHG]
		  +[PIG_VACC_ISSUE]
		  +[PIG_VET_CHG]
		  +[REPAIR_MAINT]
		  +[REPAIR_PARTS]
		  +[SITE_COST_ACCUM]
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
into #amt
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where mg_week between @start and @mg_week 
group by Reporting_Group_Description, reportinggroupid


select wr.reportinggroupid,( sum([Lact_sow_Days]) / 385) lday385
into #Ldays
from [dbo].[cft_SowMart_weekly_Rollup] wr
where wr.picyear_week between @w77 and @w23
group by wr.reportinggroupid


--select wr.reportinggroupid,( ( sum([gest_sow_Days]) + sum([nonprod_sow_Days]) )  / 490) gday490	
select wr.reportinggroupid,( sum([gest_sow_Days])   / 483) gday483	
into #Gdays
from [dbo].[cft_SowMart_weekly_Rollup] wr
where wr.picyear_week between @w94 and @w26
group by wr.reportinggroupid


--select S.Reporting_Group_Description
--, cost.TotCost/( (isnull(ngain.nur_wgt_gain,0) + isnull(fgain.FIN_wgt_gain,0) + isnull(wgain.wtf_wgt_gain,0))/100 ) as TotCost_of_gain_per_cwtL
--, cost.TotCost/(amt.sold_wt/100) as TotCost_per_cwtL
--, ((sum(prim_wt) + sum(cull_wt)) / 100) mrkted_wgt_cwt, (sum(prim_wt) + sum(cull_wt)) mrkted_wgt
--from


select amt.reportinggroupid, amt.reporting_group_description
--, cost.TotCost/(amt.sold_wt/100) as TotCost_per_cwtL
, SC.totalcost/amt.mrkted_wgt_cwt as cost_per_cwt
, SC.totalcost
, amt.mrkted_wgt_cwt as cwt
--  , (w51w00.wtsold)/ (#ldays.lday385 + #gdays.gday483) as [LBS mkt per inv sow per year]
  , (w51w00.wtsold)/ (#ldays.lday385 + #gdays.gday483) as lbs_sow_year
from  #amt amt
left join #cost SC
	on SC.reportinggroupid = amt.reportinggroupid 
left join #w51w00 w51w00
	on w51w00.reportinggroupid = amt.reportinggroupid
left join #Ldays
	on #Ldays.reportinggroupid = amt.reportinggroupid
left join #Gdays
	on #Gdays.reportinggroupid = amt.reportinggroupid
where amt.reporting_group_description is not null
--and SI.reportinggroupid > 0
order by cost_per_cwt desc



END















