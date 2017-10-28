


CREATE PROCEDURE [dbo].[cfp_SITE_FLOW_PERFORMANCE]
	@PhaseID CHAR(3)
,	@StartPeriod CHAR(6)
,	@EndPeriod CHAR(6)
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------
SELECT
	--RTRIM(TaskID) TaskID
	--RTRIM(mgr.MasterGroup) MasterGroup
	RTRIM(mgr.SiteContactID) SiteContactID
,	RTRIM(c.ContactName) as SiteName
,	mgr.PigFlowID
,	RTRIM(pf.PigFlowDescription) as PigFlow
--,	mgr.ActCloseDate
--,	mgr.ActStartDate
--,	RTRIM(mgr.SrSvcManager) SrSvcManager
--,	RTRIM(mgr.SvcManager) SvcManager
,	SUM(mgr.HeadStarted) HeadStarted
,	SUM(mgr.TotalHeadProduced) TotalHeadProduced
,	Mortality = case when isnull(SUM(mgr.HeadStarted),0) <> 0
			then (cast(isnull(SUM(mgr.PigDeath_Qty),0) as numeric(14,2)) / cast(SUM(mgr.HeadStarted) as numeric(14,2))) * 100
			else 0 end
,	AverageDailyGain = case when isnull(SUM(mgr.TotalPigDays),0) <> 0
				then isnull(SUM(mgr.WeightGained),0) / SUM(mgr.TotalPigDays)
				else 0 end
,	AdjAverageDailyGain = 
		case 
			when mgr.Phase = 'NUR'
				then case when case when isnull(Sum(mgr.TotalPigDays),0) <> 0
				then isnull(Sum(mgr.WeightGained),0) / Sum(mgr.TotalPigDays)
				else 0 end > 0 then isnull(Sum(mgr.WeightGained),0) / Sum(mgr.TotalPigDays) 
				+ ((50 - case when (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(mgr.Prim_Wt),0) + isnull(Sum(mgr.Cull_Wt),0) + isnull(Sum(mgr.DeadPigsToPacker_Wt),0) + isnull(Sum(mgr.TransferToTailender_Wt),0) + isnull(Sum(mgr.TransferOut_Wt),0) + isnull(Sum(mgr.TransportDeath_Wt),0)) / (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0))
				else 0 end) * 0.005) else 0 end 
			
			when mgr.Phase = 'FIN'
				then case when case when isnull(Sum(mgr.TotalPigDays),0) <> 0
				then isnull(Sum(mgr.WeightGained),0) / Sum(mgr.TotalPigDays)
				else 0 end > 0 then isnull(Sum(mgr.WeightGained),0) / Sum(mgr.TotalPigDays)
				+ ((50 - case when isnull(Sum(mgr.TransferIn_Qty),0) <> 0
				then isnull(Sum(mgr.TransferIn_Wt),0) / Sum(mgr.TransferIn_Qty) else 0 end) * 0.005)
				+ ((270 - case when (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(mgr.Prim_Wt),0) + isnull(Sum(mgr.Cull_Wt),0) + isnull(Sum(mgr.DeadPigsToPacker_Wt),0) + isnull(Sum(mgr.TransferToTailender_Wt),0) + isnull(Sum(mgr.TransferOut_Wt),0) + isnull(Sum(mgr.TransportDeath_Wt),0)) / (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0))
				else 0 end) * 0.001) else 0 end 
			else case when isnull(Sum(mgr.TotalPigDays),0) <> 0
				then isnull(Sum(mgr.WeightGained),0) / Sum(mgr.TotalPigDays)
				else 0 end
		end
,	FeedToGain = case when isnull(SUM(mgr.WeightGained),0) <> 0
				then isnull(SUM(mgr.Feed_Qty),0) / SUM(mgr.WeightGained)
				else 0 end
,	AdjFeedToGain = case when mgr.Phase = 'NUR'
				then Avg(mgr.FeedToGain) + ((50 - Avg(mgr.AverageOut_Wt)) * 0.005)
				when mgr.Phase = 'FIN'
				then Avg(mgr.FeedToGain) + ((50 - Avg(mgr.AveragePurchase_Wt)) * 0.005) + ((270 - Avg(mgr.AverageOut_Wt)) * 0.005)
				else Avg(mgr.FeedToGain) end
,	AverageDailyFeedIntake = case when isnull(SUM(mgr.TotalPigDays),0) <> 0
				then isnull(SUM(mgr.Feed_Qty),0) / SUM(mgr.TotalPigDays)
				else 0 end
,	MedicationCostPerHead = case when isnull(SUM(mgr.TotalHeadProduced),0) <> 0
				then isnull(SUM(mgr.MedicationCost),0) / SUM(mgr.TotalHeadProduced)
				else 0 end
,	AveragePurchase_Wt = CAST(case when isnull(Sum(mgr.TransferIn_Qty),0) <> 0
				then isnull(Sum(mgr.TransferIn_Wt),0) / Sum(mgr.TransferIn_Qty)
				else 0 end AS NUMERIC(14,1)) 
,	AverageOut_Wt = CAST(case when (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(mgr.Prim_Wt),0) + isnull(Sum(mgr.Cull_Wt),0) + isnull(Sum(mgr.DeadPigsToPacker_Wt),0) + isnull(Sum(mgr.TransferToTailender_Wt),0) + isnull(Sum(mgr.TransferOut_Wt),0) + isnull(Sum(mgr.TransportDeath_Wt),0)) / (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0))
				else 0 end AS NUMERIC(14,1)) 
,	DeadPigsToPacker_Pct = case when isnull(SUM(mgr.HeadStarted),0) <> 0
				then (cast(isnull(SUM(mgr.DeadPigsToPacker_Qty),0) as numeric(14,2)) / cast(SUM(mgr.HeadStarted) as numeric(14,2))) * 100
				else 0 end
,	Cull_Pct = case when isnull(SUM(mgr.HeadStarted),0) <> 0
				then (cast(isnull(SUM(mgr.Cull_Qty),0) as numeric(14,2)) / cast(SUM(mgr.HeadStarted) as numeric(14,2))) * 100
				else 0 end
,	Tailender_Pct = case when isnull(SUM(mgr.HeadStarted),0) <> 0
				then (cast(isnull(SUM(mgr.TransferToTailender_Qty),0) as numeric(14,2)) / cast(SUM(mgr.HeadStarted) as numeric(14,2))) * 100
				else 0 end
,	NoValue_Pct = case when isnull(SUM(mgr.HeadStarted),0) <> 0
				then ((cast(isnull(SUM(mgr.TransportDeath_Qty),0) as numeric(14,2)) + cast(isnull(SUM(mgr.DeadPigsToPacker_Qty),0) as numeric(14,2))) / cast(SUM(mgr.HeadStarted) as numeric(14,2))) * 100
				else 0 end
,	AvgDaysInBarn = (Sum(mgr.PigCapacityDays) + Sum(mgr.EmptyCapacityDays)) / Sum(mgr.HeadCapacity)
,	SUM(mgr.InventoryAdjustment_Qty) InventoryAdjustment_Qty
,	SUM(mgr.FeedCost) FeedCost
,	SUM(mgr.MedicationCost) MedCost
,	SUM(mgr.VaccinationCost) VacCost
,	SUM(COG.PIGS_TRUCKING_COST) PigTruckingCost
,	SUM(COG.PIGS_SITE_COST) PigSiteCost
,	SUM(COG.PIGS_RM_COST) PigRMCost
,	SUM(COG.PIGS_VET_COST) PigVetCost
,	SUM(COG.PIGS_SUPPLY_COST) PigSupplyCost
,	SUM(COG.PIGS_DEATH) PigDeathCost
,	SUM(COG.PIGS_TRANSPORT_COST) PigTransportCost
,	SUM(COG.PIGS_OVR_HD_COST) PigOvrHdCost
,	SUM(COG.PIGS_OVR_HD_CHG) PigOvhHdChg
,	SUM(COG.PIGS_INT_WC_CHG) PigIntWCChg
,	SUM(COG.PIGS_MISC_EXP_CHG) PigMiscExpChg

FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP mgr

left join (

	Select
	PigCost.MasterGroup,
	Sum(PigCost.PIGS_TRUCKING_COST) PIGS_TRUCKING_COST,
	Sum(PigCost.PIGS_SITE_COST) PIGS_SITE_COST,
	Sum(PigCost.PIGS_RM_COST) PIGS_RM_COST,
	Sum(PigCost.PIGS_VET_COST) PIGS_VET_COST,
	Sum(PigCost.PIGS_SUPPLY_COST) PIGS_SUPPLY_COST,
	Sum(PigCost.PIGS_DEATH) PIGS_DEATH,
	Sum(PigCost.PIGS_TRANSPORT_COST) PIGS_TRANSPORT_COST,
	Sum(PigCost.PIGS_OVR_HD_COST) PIGS_OVR_HD_COST,
	Sum(PigCost.PIGS_OVR_HD_CHG) PIGS_OVR_HD_CHG,
	Sum(PigCost.PIGS_INT_WC_CHG) PIGS_INT_WC_CHG,
	Sum(PigCost.PIGS_MISC_EXP_CHG) PIGS_MISC_EXP_CHG

	from (
	
	Select
	pg.CF03 as 'MasterGroup',
	case when pjp.Acct in ('PIG TRUCKING IN','PIG TRUCKING CHG') then sum(pjp.act_amount) else 0 end as PIGS_TRUCKING_COST,
	case when pjp.Acct in ('PIG SITE CHG') then sum(pjp.act_amount) else 0 end as PIGS_SITE_COST,
	case when pjp.Acct in ('REPAIR & MAINT') then sum(pjp.act_amount) else 0 end as PIGS_RM_COST,
	case when pjp.Acct in ('PIG VET CHG') then sum(pjp.act_amount) else 0 end as PIGS_VET_COST,
	case when pjp.Acct in ('SUPPLIES') then sum(pjp.act_amount) else 0 end as PIGS_SUPPLY_COST,
	case when pjp.Acct in ('PIG DEATH')	then sum(pjp.act_amount) else 0 end as PIGS_DEATH,
	case when pjp.Acct in ('TRANSPORT DEATH') then sum(pjp.act_amount) else 0 end as PIGS_TRANSPORT_COST,
	case when pjp.Acct in ('PIG OVR HD COST') then sum(pjp.act_amount) else 0 end as PIGS_OVR_HD_COST,
	case when pjp.Acct in ('PIG OVR HD CHG') then sum(pjp.act_amount) else 0 end as PIGS_OVR_HD_CHG,
	case when pjp.Acct in ('PIG INT WC CHG') then sum(pjp.act_amount) else 0 end as PIGS_INT_WC_CHG,
	case when pjp.Acct in ('PIG MISC EXP') then sum(pjp.act_amount) else 0 end as PIGS_MISC_EXP_CHG
	FROM [$(SolomonApp)].dbo.cftPigGroup AS pg WITH (NOLOCK)
	LEFT OUTER JOIN [$(SolomonApp)].dbo.cftPigProdPhase AS p WITH (NOLOCK)
	ON pg.PigProdPhaseID = p.PigProdPhaseID
	LEFT OUTER JOIN [$(SolomonApp)].dbo.PJPTDSUM pjp WITH (NOLOCK)
	on pjp.pjt_entity = pg.TaskID
	WHERE
	pg.PGStatusID='I'
	and PG.ActCloseDate>='12/28/2008'
	--and pg.PigProdPhaseID in ('FIN','NUR')
	and PG.PigSystemID = '00'
	--and pjp.Acct in ('PIG TRUCKING IN','PIG TRUCKING CHG')
	group by
	pg.CF03,
	pjp.Acct) PigCost
	
	Group by
	PigCost.MasterGroup) COG 
on mgr.MasterGroup = COG.MasterGroup

left join [$(SolomonApp)].dbo.cftContact c
on mgr.SiteContactID = c.ContactID 
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
on mgr.PigFlowID = pf.PigFlowID
left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dd
on mgr.ActCloseDate = dd.DayDate
Where Case when dd.FiscalPeriod < 10 
then Rtrim(CAST(dd.FiscalYear AS char)) + '0' + Rtrim(CAST(dd.FiscalPeriod AS char)) 
else Rtrim(CAST(dd.FiscalYear AS char)) + Rtrim(CAST(dd.FiscalPeriod AS char)) end between @StartPeriod and @EndPeriod
and mgr.Phase = @PhaseID
--	RTRIM(MasterGroup) = '26570'
GROUP BY
	mgr.SiteContactID
,	c.ContactName
,	mgr.PigFlowID
,	pf.PigFlowDescription
--,	mgr.ActCloseDate
--,	mgr.ActStartDate
--,	mgr.SrSvcManager
--,	mgr.SvcManager
,	mgr.Phase
ORDER BY mgr.SiteContactID

----PRINT 'PicStartDate = ' + cast(@PicStartDate as varchar)
----PRINT 'PicEndDate = ' + cast(@PicEndDate as varchar)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_SITE_FLOW_PERFORMANCE] TO [db_sp_exec]
    AS [dbo];

