



-- =============================================
-- Author:		SRipley, dbo.cfp_REPORT_SLF_rpt4
-- Create date: 08/03/2010
-- Description:	This procedure provides the data for the StraightLineFlow Report
--
-- =============================================
CREATE PROCEDURE [dbo].[cfp_REPORT_SLF_cost_per_cwt]
	@mg_week char(6)
	
	AS
BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
SET NOCOUNT ON;

declare @startday datetime
declare @start char(6)

-- get last date value for the selected week
select @startday = max(daydate) from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where picyear_week = @mg_week

select @start = picyear_week from [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo
where daydate = dateadd(d,-182,@startday)


select cost.PigFlowID,cost.PigFlowDescription, totalcost/cwt as cost_per_cwt, totalcost, cwt
,((cwt*100)/case
	when cost.pigflowid = 0 then 5809	--c19
	when cost.pigflowid = 7 then 2809	--c19
	when cost.pigflowid = 9 then 2853	-- c26
	when cost.pigflowid = 10 then 1853	-- c26
	when cost.pigflowid = 11 then 1526	-- C39
	when cost.pigflowid = 12 then 2526	-- C39
	when cost.pigflowid = 13 then 1617 -- c42
	when cost.pigflowid = 21 then 1347 -- c10
	when cost.pigflowid = 22 then 1397 -- c20
	when cost.pigflowid = 23 then 1402 -- c13
	when cost.pigflowid = 24 then 1370 -- c15
	when cost.pigflowid = 32 then 1683 -- c38
	when cost.pigflowid = 33 then 1330 -- c02
	when cost.pigflowid = 34 then 1382 -- c16
	when cost.pigflowid = 39 then 3337 -- c58
	when cost.pigflowid = 37 then 1978 -- c58
	when cost.pigflowid = 40 then 4873 -- m5,m6
	when cost.pigflowid = 43 then 2873
	when cost.pigflowid = 46 then 3328
	when cost.pigflowid = 47 then 4523
	when cost.pigflowid = 48 then 1335
	when cost.pigflowid = 49 then 1386
	when cost.pigflowid = 50 then 2724
	when cost.pigflowid = 53 then 1332
	when cost.pigflowid = 54 then 1561
	when cost.pigflowid = 55 then 1598
	when cost.pigflowid = 56 then 1580
	when cost.pigflowid = 50 then 2724
	when cost.pigflowid = 59 then 1182
	when cost.pigflowid = 60 then 3157
	when cost.pigflowid = 61 then 1587
	when cost.pigflowid = 62 then 1599
	when cost.pigflowid = 63 then 1371
	when cost.pigflowid = 66 then 2761
	when cost.pigflowid = 68 then 4231
	when cost.pigflowid = 69 then 690
	when cost.pigflowid = 70 then 1789
	when cost.pigflowid = 71 then 4143
	when cost.pigflowid = 72 then 2450
	when cost.pigflowid = 73 then 4446
	when cost.pigflowid = 74 then 4986
	when cost.pigflowid = 75 then 2460
end)*2 as lbs_sow_year
from 
(  SELECT [PigFlowID]	
      ,[PigFlowDescription]	
      ,SUM([FEED_ISSUE]) as [FEED_ISSUE]
      ,SUM([FREIGHT]) as [FREIGHT]
      ,SUM([MISC_JOB_CHARGES]) as [MISC_JOB_CHARGES]
      ,SUM([OTHER_REVENUE]) as [OTHER_REVENUE]
      ,SUM([PIG_BASE_DOLLARS]) as [PIG_BASE_DOLLARS]
      ,SUM([PIG_DEATH]) as [PIG_DEATH]
      ,SUM([PIG_FEED_DELIV]) as [PIG_FEED_DELIV]
      ,SUM([PIG_FEED_GRD_MIX]) as [PIG_FEED_GRD_MIX]
      ,SUM([PIG_FEED_ISSUE]) as [PIG_FEED_ISSUE]
      ,SUM([PIG_GRADE_PREM]) as [PIG_GRADE_PREM]
      ,SUM([PIG_INT_WC_CHG]) as [PIG_INT_WC_CHG]
      ,SUM([PIG_MEDS_CHG]) as [PIG_MEDS_CHG]
      ,SUM([PIG_MEDS_ISSUE]) as [PIG_MEDS_ISSUE]
      ,SUM([PIG_MISC_EXP]) as [PIG_MISC_EXP]
      ,SUM([PIG_MKT_TRUCKING]) as [PIG_MKT_TRUCKING]
      ,SUM([PIG_MOVE_IN]) as [PIG_MOVE_IN]
      ,SUM([PIG_MOVE_OUT]) as [PIG_MOVE_OUT]
      ,SUM([PIG_OVR_HD_CHG]) as [PIG_OVR_HD_CHG]
      ,SUM([PIG_OVR_HD_COST]) as [PIG_OVR_HD_COST]
      ,SUM([PIG_PURCHASE]) as [PIG_PURCHASE]
      ,SUM([PIG_SALE]) as [PIG_SALE]
      ,SUM([PIG_SALE_DED_OTR]) as [PIG_SALE_DED_OTR]
      ,SUM([PIG_SITE_CHG]) as [PIG_SITE_CHG]
      ,SUM([PIG_SORT_LOSS]) as [PIG_SORT_LOSS]
      ,SUM([PIG_TRANSFER_IN]) as [PIG_TRANSFER_IN]
      ,SUM([PIG_TRANSFER_OUT]) as [PIG_TRANSFER_OUT]
      ,SUM([PIG_TRUCKING_CHG]) as [PIG_TRUCKING_CHG]
      ,SUM([PIG_TRUCKING_IN]) as [PIG_TRUCKING_IN]
      ,SUM([PIG_VACC_CHG]) as [PIG_VACC_CHG]
      ,SUM([PIG_VACC_ISSUE]) as [PIG_VACC_ISSUE]
      ,SUM([PIG_VET_CHG]) as [PIG_VET_CHG]
      ,SUM([REPAIR_MAINT]) as [REPAIR_MAINT]
      ,SUM([REPAIR_PARTS]) as [REPAIR_PARTS]
      ,SUM([SITE_COST_ACCUM]) as [SITE_COST_ACCUM]
      ,SUM([SUPPLIES]) as [SUPPLIES]
      ,SUM([TRANSPORT_DEATH]) as [TRANSPORT_DEATH]
      ,sum([FEED_ISSUE]+ [FREIGHT] + [MISC_JOB_CHARGES]+ [OTHER_REVENUE] 
      --+ [PIG_BASE_DOLLARS]	this is revenue
			+ [PIG_DEATH]
            + [PIG_FEED_DELIV] + [PIG_FEED_GRD_MIX] + [PIG_FEED_ISSUE] 
      --+ [PIG_GRADE_PREM]  this is revenue
			+ [PIG_INT_WC_CHG]+ [PIG_MEDS_CHG]
            + [PIG_MEDS_ISSUE] + [PIG_MISC_EXP] + [PIG_MKT_TRUCKING] + [PIG_MOVE_IN] + [PIG_MOVE_OUT]+ [PIG_OVR_HD_CHG] 
            + [PIG_OVR_HD_COST] + [PIG_PURCHASE] + [PIG_SALE] + [PIG_SALE_DED_OTR]+  [PIG_SITE_CHG] + [PIG_SORT_LOSS] 
			+ [PIG_TRANSFER_IN] + [PIG_TRANSFER_OUT] + [PIG_TRUCKING_CHG]+ [PIG_TRUCKING_IN] + [PIG_VACC_CHG] + [PIG_VACC_ISSUE] 
			+ [PIG_VET_CHG] + [REPAIR_MAINT] + [REPAIR_PARTS] + [SITE_COST_ACCUM] + [SUPPLIES] + [TRANSPORT_DEATH] ) totalcost

  FROM [dbo].[cft_SLF_ESSBASE_DATA_costs] (nolock) 
  where mg_week between @start and @mg_week
  group by pigflowid ,PigFlowDescription) cost
  
  inner join 
  
  ( select pigflowid, ((sum(prim_wt) + sum(cull_wt)) / 100) cwt
    from cft_slf_essbase_data d
    where mg_week between @start and @mg_week
    group by pigflowid ) wgt
		on wgt.pigflowid = cost.pigflowid



  	


END

