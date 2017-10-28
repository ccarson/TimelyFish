


-- =============================================
-- Author:		Mike Zimanski
-- Create date: 02/23/2012
-- Description:	Site Flow Results
-- =============================================
CREATE PROCEDURE [dbo].[cfp_FLOW]
(
	
	 @StartPeriod		char(6),
	 @EndPeriod			char(6),
	 @PhaseDesc			char(20)
   
)

AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Select 
	--pgr.TaskID,
	--pgr.SiteContactID,
	--c.ContactName,
	--pgr.PigFlowID,
	pf.PigFlowDescription,
	--pgr.ActCloseDate,
	--Case when dd.FiscalPeriod < 10 
	--then Rtrim(CAST(dd.FiscalYear AS char)) + '0' + Rtrim(CAST(dd.FiscalPeriod AS char)) 
	--else Rtrim(CAST(dd.FiscalYear AS char)) + Rtrim(CAST(dd.FiscalPeriod AS char)) end as 'FYPeriod',
	--pgr.Phase,
	--pgr.PhaseDesc,
	--pgr.LivePigDays,
	--pgr.DeadPigDays,
	--pgr.TotalPigDays,
	--pgr.Feed_Qty,
	--pgr.TransferIn_Qty,
	--pgr.MoveIn_Qty,
	--pgr.MoveOut_Qty,
	--pgr.PigDeath_Qty,
	--pgr.TransferOut_Qty,
	--pgr.TransferToTailender_Qty,
	--pgr.Prim_Qty,
	--pgr.Cull_Qty,
	--pgr.DeadPigsToPacker_Qty,
	--pgr.TransportDeath_Qty,
	--pgr.InventoryAdjustment_Qty,
	--pgr.Top_Qty,
	--pgr.TransferIn_Wt,
	--pgr.MoveIn_Wt,
	--pgr.MoveOut_Wt,
	--pgr.TransferOut_Wt,
	--pgr.TransferToTailender_Wt,
	--pgr.Prim_Wt,
	--pgr.Cull_Wt,
	--pgr.DeadPigsToPacker_Wt,
	--pgr.TransportDeath_Wt,
	--pgr.Top_Wt,
	--pgr.MedicationCost,
	--pgr.WeightGained,
	--pgr.HeadStarted,
	Sum(pgr.TotalHeadProduced) as 'TotalHeadProduced',
	--pgr.AverageDailyGain,
	AdjAverageDailyGain = 
		case 
			when pgr.Phase = 'NUR'
				then case when isnull(Sum(pgr.TotalHeadProduced),0) = 0 then 0 
				else case when (Sum(pgr.LivePigDays) / Sum(pgr.TotalHeadProduced)) <= 43
				then ((43 - (Sum(pgr.LivePigDays) / Sum(pgr.TotalHeadProduced))) * 0.015) + case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(Sum(WeightGained),0) / Sum(TotalPigDays) else 0 end
				else case when isnull(Sum(TotalPigDays),0) <> 0 then isnull(Sum(WeightGained),0) / Sum(TotalPigDays) else 0 end - (((Sum(pgr.LivePigDays) / Sum(pgr.TotalHeadProduced)) - 43) * 0.015) end end 
			
			when pgr.Phase = 'FIN'
				then case when case when isnull(Sum(pgr.TotalPigDays),0) <> 0
				then isnull(Sum(pgr.WeightGained),0) / Sum(pgr.TotalPigDays)
				else 0 end > 0 then isnull(Sum(pgr.WeightGained),0) / Sum(pgr.TotalPigDays)
				+ ((50 - case when isnull(Sum(pgr.TransferIn_Qty),0) <> 0
				then isnull(Sum(pgr.TransferIn_Wt),0) / Sum(pgr.TransferIn_Qty) else 0 end) * 0.005)
				+ ((270 - case when (isnull(Sum(pgr.TotalHeadProduced),0) + isnull(Sum(pgr.TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(pgr.Prim_Wt),0) + isnull(Sum(pgr.Cull_Wt),0) + isnull(Sum(pgr.DeadPigsToPacker_Wt),0) + isnull(Sum(pgr.TransferToTailender_Wt),0) + isnull(Sum(pgr.TransferOut_Wt),0) + isnull(Sum(pgr.TransportDeath_Wt),0)) / (isnull(Sum(pgr.TotalHeadProduced),0) + isnull(Sum(pgr.TransportDeath_Qty),0))
				else 0 end) * 0.001) else 0 end 
			else case when isnull(Sum(pgr.TotalPigDays),0) <> 0
				then isnull(Sum(pgr.WeightGained),0) / Sum(pgr.TotalPigDays)
				else 0 end
		end,
	AdjFeedToGain = case 
			when Phase = 'NUR'
				then case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0) / Sum(WeightGained) else 0 end + ((50 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0 then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
			when Phase = 'FIN'
				then case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0) / Sum(WeightGained) else 0 end + ((50 - case when isnull(Sum(TransferIn_Qty),0) <> 0 then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty) else 0 end) * 0.005) + ((270 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0 then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
			when Phase = 'WTF'
				then case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0) / Sum(WeightGained) else 0 end + ((270 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0 then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) else 0 end) * 0.005)
			else case when isnull(Sum(WeightGained),0) <> 0 then isnull(Sum(Feed_Qty),0) / Sum(WeightGained) else 0 end
		end,
	Mortality = case when isnull(SUM(pgr.HeadStarted),0) <> 0
			then (cast(isnull(SUM(pgr.PigDeath_Qty),0) as numeric(14,2)) / cast(SUM(pgr.HeadStarted) as numeric(14,2))) * 100
			else 0 end
	--pgr.FeedToGain,
	--pgr.AdjFeedToGain,
	--pgr.Mortality,
	--pgr.AveragePurchase_Wt,
	--pgr.AverageOut_Wt,
	--pgr.AverageDailyFeedIntake,
	--pgr.Tailender_Pct,
	--pgr.DeadPigsToPacker_Pct,
	--pgr.Cull_Pct,
	--pgr.NoValue_Pct,
	--pgr.MedicationCostPerHead,
	--pgr.VaccinationCost,
	--pgr.FeedCost,
	--pgr.HeadCapacity,
	--pgr.HeadSold,
	--pgr.AverageMarket_Wt,
	--pgr.DaysInGroup,
	--pgr.PigCapacityDays,
	--pgr.EmptyDays,
	--pgr.EmptyCapacityDays,
	--pgr.CapacityDays,
	--pgr.TotalCapacityDays,
	--pgr.AverageDaysInGroup,
	--pgr.AverageEmptyDays,
	--pgr.Utilization,
	--pgr.MedicationCostPerHeadSold,
	--pgr.VaccinationCostPerHeadSold,
	--pgr.FeedCostPerHundredGain
	from  dbo.cft_PIG_GROUP_ROLLUP pgr
	left join [$(SolomonApp)].dbo.cftContact c
	on pgr.SiteContactID = c.ContactID
	left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
	on pgr.PigFlowID = pf.PigFlowID
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
	on pgr.MasterActCloseDate = dd.DayDate
	
	Where Case when dd.FiscalPeriod < 10 
	then Rtrim(CAST(dd.FiscalYear AS char)) + '0' + Rtrim(CAST(dd.FiscalPeriod AS char)) 
	else Rtrim(CAST(dd.FiscalYear AS char)) + Rtrim(CAST(dd.FiscalPeriod AS char)) end between @StartPeriod and @EndPeriod
	and pgr.PhaseDesc = @PhaseDesc
	
	Group by
	--pgr.SiteContactID,
	--c.ContactName,
	--pgr.PigFlowID,
	pf.PigFlowDescription,
	pgr.Phase
	
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_FLOW] TO [db_sp_exec]
    AS [dbo];

