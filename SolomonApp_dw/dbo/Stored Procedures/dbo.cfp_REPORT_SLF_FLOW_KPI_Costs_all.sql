



-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Costs_rank
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_Costs_all]
   @pg_week char(6)

	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startday datetime
declare @start char(6)

--declare @pg_week char(6)
--select @pg_week = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
--where daydate = cast(getdate() as date)



-- get last date value for the selected week
select @startday = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@startday)

select distinct reportinggroupid, Reporting_Group_Description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @start and @pg_week

 

 
-- wean pig cost per pig 
 select sed.reportinggroupid, sum(dc.pig_transfer_in)/sum(sed.transferinwp_qty) as avgwpcost
into #wpc
from [dbo].[cft_SLF_ESSBASE_DATA] sed (nolock)
join [dbo].[cft_SLF_ESSBASE_DATA_COSTS] DC (nolock)
	on dc.combwtfgroup = sed.group_number
where sed.pg_week between @start and @pg_week
  and sed.phase in ('nur','wtf')	--= 'nur'
group by sed.reportinggroupid

-- feeder pig cost per pig
select sed.reportinggroupid, sum(sed.transferout_qty) transferout_qty
 		  ,sum([FEED_ISSUE] + [FREIGHT]+[MISC_JOB_CHARGES]
		  +[PIG_DEATH]	+[PIG_FEED_DELIV]	+[PIG_FEED_GRD_MIX]	+[PIG_FEED_ISSUE]
		  +[PIG_INT_WC_CHG]	+[PIG_MEDS_CHG] +[PIG_MEDS_ISSUE] +[PIG_MISC_EXP]
		  +[PIG_MOVE_IN] +[PIG_MOVE_OUT] +[PIG_OVR_HD_CHG] +[PIG_OVR_HD_COST] +[PIG_PURCHASE]
		  +[PIG_SITE_CHG] +[PIG_TRANSFER_IN] +[PIG_TRANSFER_OUT] +[PIG_TRUCKING_CHG] +[PIG_TRUCKING_IN] +[PIG_VACC_CHG] +[PIG_VACC_ISSUE]
		  +[PIG_VET_CHG] +[REPAIR_MAINT] +[REPAIR_PARTS] +[SITE_COST_ACCUM] +[SUPPLIES]  +[TRANSPORT_DEATH]) as TotCost
, sum([FEED_ISSUE] + [FREIGHT]+[MISC_JOB_CHARGES]
		  +[PIG_DEATH]	+[PIG_FEED_DELIV]	+[PIG_FEED_GRD_MIX]	+[PIG_FEED_ISSUE]
		  +[PIG_INT_WC_CHG]	+[PIG_MEDS_CHG] +[PIG_MEDS_ISSUE] +[PIG_MISC_EXP]
		  +[PIG_MOVE_IN] +[PIG_MOVE_OUT] +[PIG_OVR_HD_CHG] +[PIG_OVR_HD_COST] +[PIG_PURCHASE]
		  +[PIG_SITE_CHG] +[PIG_TRANSFER_IN] +[PIG_TRANSFER_OUT] +[PIG_TRUCKING_CHG] +[PIG_TRUCKING_IN] +[PIG_VACC_CHG] +[PIG_VACC_ISSUE]
		  +[PIG_VET_CHG] +[REPAIR_MAINT] +[REPAIR_PARTS] +[SITE_COST_ACCUM] +[SUPPLIES]  +[TRANSPORT_DEATH])  / sum(sed.transferout_qty) avgfdcost
into #fpc
from [dbo].[cft_SLF_ESSBASE_DATA] sed (nolock)
join [dbo].[cft_SLF_ESSBASE_DATA_COSTS] DC (nolock)
	on dc.combwtfgroup = sed.group_number
where sed.pg_week between @start and @pg_week
  and sed.phase = 'nur'
group by sed.reportinggroupid



-- Weight Gain   NUR
select Reporting_Group_Description, sum(transferinwp_wt) TIwp_wt, sum(transferout_wt) TO_wt
--, sum(transferout_wt) - sum(transferinwp_wt) Nur_wgt_gain
, (sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt)) - (sum(transferinwp_wt) + sum(transferin_wt) +  sum(movein_wt)) nur_wgt_gain
into #nur_wgt_gain
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @start and @pg_week  
and phase = 'nur'
group by Reporting_Group_Description

-- weight gain FIN
select Reporting_Group_Description
, sum(transferin_wt) TI_wt, sum(movein_wt) MI_wt, (sum(transferin_wt) +  sum(movein_wt)) IN_wgt
, sum(moveout_wt) MO_wt,sum(pigdeathtd_wt) PDTD_wt,sum(transportdeath_wt) TD_wt, sum(transferout_wt) TO_wt, sum(transfertotailender_wt) TE_wt, sum(prim_wt) P_wt, sum(cull_wt) C_wt, sum(deadontruck_wt) DOT_wt, sum(deadinyard_wt) DIY_wt, sum(condemn_wt) Con_wt
, (sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt)) OUT_wgt  
, (sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt)) - (sum(transferinwp_wt) + sum(transferin_wt) +  sum(movein_wt)) FIN_wgt_gain
into #fin_wgt_gain
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @start and @pg_week   
and phase = 'fin'
group by Reporting_Group_Description

-- weight gain WTF
select Reporting_Group_Description
, sum(transferin_wt) TI_wt, sum(transferinWP_wt) TIwp_wt, sum(movein_wt) MI_wt, (sum(transferinwp_wt) + sum(transferin_wt) +  sum(movein_wt)) IN_wgt
, sum(moveout_wt) MO_wt,sum(pigdeathtd_wt) PDTD_wt,sum(transportdeath_wt) TD_wt, sum(transferout_wt) TO_wt, sum(transfertotailender_wt) TE_wt, sum(prim_wt) P_wt, sum(cull_wt) C_wt, sum(deadontruck_wt) DOT_wt, sum(deadinyard_wt) DIY_wt, sum(condemn_wt) Con_wt
, (sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt)) OUT_wgt  
, (sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt)) - (sum(transferinwp_wt) + sum(transferin_wt) +  sum(movein_wt)) wtf_wgt_gain
into #wtf_wgt_gain
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @start and @pg_week   
and phase = 'wtf'
group by Reporting_Group_Description

 



	
select @pg_week, s.reportinggroupid, S.Reporting_Group_Description
--1.	WP Cost/Pig = 		Sum(Transfer In Feeder Costs) / Sum(Transfer In Feeder Qty) 6 month interval     	
--				or			Sum(Transfer Out WP Costs) / Sum(Transfer Out WP Qty) 6 month interval
, #wpc.avgwpcost as WP_CostPerPig
--, cost.PIG_TRANSFER_IN/amt.transferin_qty as FP_CostPerPig
--3.	Feed Cost of Gain/cwt = (Total Feed Cost (Fin)+Total Feed Cost (Nur)+Total Feed Cost(WTF)) /(((Total Out Wt Fin– Total In Wt Fin)+(Total Out Wt Nur –Total In Wt Nur)+(Total Out Wt WTF-Total In Wt WTF))/100) 6 month interval
, #fpc.avgfdcost as FP_CostPerPig
, cost.feed_cost/( (isnull(ngain.nur_wgt_gain,0) + isnull(fgain.FIN_wgt_gain,0) + isnull(wgain.wtf_wgt_gain,0)) / 100 ) as Feed_Cost_of_Gain
, (cost.TotCost - cost.WPTcost)/( (isnull(ngain.nur_wgt_gain,0) + isnull(fgain.FIN_wgt_gain,0) + isnull(wgain.wtf_wgt_gain,0))/100 ) as TotCost_of_gain_per_cwtL
, cost.revenue/(amt.OUT_wgt/100) as revenue_per_cwtL
, (cost.revenue - cost.TotCost) /(amt.OUT_wgt/100)  as margin_per_cwtL
, cost.meds_cost/amt.sold_qty as Med_per_HS
, cost.vacc_cost/amt.sold_qty as Vacc_per_HS
, cost.TotCost/(amt.OUT_wgt/100) as TotCost_per_cwtL
from (select distinct reportinggroupid, Reporting_Group_Description 
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] ) S
left join #pf_list
	on #pf_list.reportinggroupid = S.reportinggroupid
left join #wpc
	on #wpc.reportinggroupid = #pf_list.reportinggroupid
left join #fpc
	on #fpc.reportinggroupid = #wpc.reportinggroupid
left join #nur_wgt_gain ngain
	on ngain.Reporting_Group_Description = #pf_list.Reporting_Group_Description
left join #fin_wgt_gain fgain
	on fgain.Reporting_Group_Description = #pf_list.Reporting_Group_Description
left join #wtf_wgt_gain wgain
	on wgain.Reporting_Group_Description = #pf_list.Reporting_Group_Description
left join
	(SELECT [Reporting_Group_Description]
		  , sum([OTHER_REVENUE] + [PIG_BASE_DOLLARS]+[PIG_SALE_DED_OTR] + PIG_SALE + PIG_SORT_LOSS+[PIG_GRADE_PREM]+[PIG_MKT_TRUCKING]) as revenue
		  , sum([PIG_TRANSFER_IN] + [PIG_MOVE_IN] + [PIG_PURCHASE] + [PIG_MOVE_OUT]) as WPTcost
		  , Sum([PIG_VACC_CHG] +  [PIG_VACC_ISSUE]) as vacc_cost
		  , Sum([PIG_MEDS_CHG] +  [PIG_MEDS_ISSUE]) as meds_cost
--3.	Feed Cost of Gain/cwt = (Total Feed Cost (Fin)+Total Feed Cost (Nur)+Total Feed Cost(WTF)) 
--								/(((Total Out Wt Fin– Total In Wt Fin)+(Total Out Wt Nur –Total In Wt Nur)+(Total Out Wt WTF-Total In Wt WTF))/100) 6 month interval
		  , Sum(PIG_FEED_ISSUE+[PIG_FEED_DELIV] +[PIG_FEED_GRD_MIX] ) as feed_cost	-- for all phases
		  , sum(pig_transfer_in) pig_transfer_in
		  ,sum(
		  --[FEED_ISSUE] + [FREIGHT]+[MISC_JOB_CHARGES]
		   [PIG_DEATH]
		  +[PIG_FEED_DELIV]
		  +[PIG_FEED_GRD_MIX]
		  +[PIG_FEED_ISSUE]
	 --     +[PIG_GRADE_PREM]
		  +[PIG_INT_WC_CHG]
		  +[PIG_MEDS_CHG]
		  +[PIG_MEDS_ISSUE]
		  +[PIG_MISC_EXP]
	 --     +[PIG_MKT_TRUCKING]	not a cost but a revenue expense??
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
	--	  +[REPAIR_PARTS]
	--	  +[SITE_COST_ACCUM]
		  +[SUPPLIES]
		  +[TRANSPORT_DEATH]) as TotCost
	  FROM [dbo].[cft_SLF_ESSBASE_DATA_COSTS]
	  where pg_week between @start and @pg_week 
	  group by Reporting_Group_Description)		cost				-------------------------   COST 
on cost.[Reporting_Group_Description] = #pf_list.[Reporting_Group_Description]
left join 
	(SELECT [Reporting_Group_Description], 
	 sum([Prim_Qty] + [Cull_Qty]) sold_qty
--	, sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt) OUT_wgt  
,sum(transportdeath_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt) OUT_wgt  
	  FROM [dbo].[cft_SLF_ESSBASE_DATA]
		where pg_week between @start and @pg_week   
	  group by Reporting_Group_Description) amt					 -----------------------------   AMT
	on amt.Reporting_Group_Description = cost.Reporting_Group_Description

END





























GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_Costs_all] TO [db_sp_exec]
    AS [dbo];

