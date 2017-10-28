











-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_FLOW_KPI_Costs
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_FLOW_KPI_Costs_rg]
	@mg_week char(6), @reportinggroupid_list varchar(50)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startday datetime
declare @start char(6)

declare @pg_week char(6)
set @pg_week = @mg_week

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

-- get last date value for the selected week
select @startday = max(daydate) from  dbo.cftDayDefinition_WithWeekInfo
where picyear_week = @pg_week

select @start = picyear_week from  dbo.cftDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@startday)

select distinct reportinggroupid, Reporting_Group_Description
into #pf_list
from [dbo].[cft_SLF_ESSBASE_DATA] 
 where pg_week between @start and @pg_week
 and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
 

 
-- wean pig cost per pig 
 select sed.reportinggroupid, sum(dc.pig_transfer_in)/sum(sed.transferinwp_qty) as avgwpcost
into #wpc
from [dbo].[cft_SLF_ESSBASE_DATA] sed (nolock)
join [dbo].[cft_SLF_ESSBASE_DATA_COSTS] DC (nolock)
	on dc.combwtfgroup = sed.group_number
where sed.pg_week between @start and @pg_week
  and sed.phase in ('nur','wtf')	--= 'nur'
  and sed.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
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
  and sed.reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by sed.reportinggroupid



-- Weight Gain   NUR
select Reporting_Group_Description, sum(transferinwp_wt) TIwp_wt, sum(transferout_wt) TO_wt
--, sum(transferout_wt) - sum(transferinwp_wt) Nur_wgt_gain
, (sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt)) - (sum(transferinwp_wt) + sum(transferin_wt) +  sum(movein_wt)) nur_wgt_gain
into #nur_wgt_gain
FROM [dbo].[cft_SLF_ESSBASE_DATA]
where pg_week between @start and @pg_week  
and phase = 'nur'
and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
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
and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
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
and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
group by Reporting_Group_Description

 



	
select S.Reporting_Group_Description
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
	  FROM [CFApp_PigManagement].[dbo].[cft_PIG_FLOW_REPORTING_GROUP] 
      where reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)	) S
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
	    and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)
	  group by Reporting_Group_Description)		cost				-------------------------   COST 
on cost.[Reporting_Group_Description] = #pf_list.[Reporting_Group_Description]
left join 
	(SELECT [Reporting_Group_Description], 
	 sum([Prim_Qty] + [Cull_Qty]) sold_qty
--	, sum(moveout_wt) + sum(pigdeathtd_wt)+ sum(transportdeath_wt)+ sum(transferout_wt)+ sum(transfertotailender_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt) OUT_wgt  
,sum(transportdeath_wt) + sum(prim_wt)+sum(cull_wt) +sum(deadontruck_wt)+sum(deadinyard_wt) +sum(condemn_wt) OUT_wgt  
	  FROM [dbo].[cft_SLF_ESSBASE_DATA]
		where pg_week between @start and @pg_week 
		  and reportinggroupid in (@pf1,@pf2,@pf3,@pf4,@pf5,@pf6,@pf7)  
	  group by Reporting_Group_Description) amt					 -----------------------------   AMT
	on amt.Reporting_Group_Description = cost.Reporting_Group_Description

END
























GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SLF_FLOW_KPI_Costs_rg] TO [db_sp_exec]
    AS [dbo];

