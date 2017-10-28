

-- ==================================================================
-- Author:		Brian Cesafsky
-- Create date: 03/05/2010
-- Description:	Returns data for the Closed Group report
-- 2/22/2016, BMD, Updated to exclude SBF Pig Groups
-- ==================================================================
CREATE PROCEDURE [dbo].[cfp_REPORT_CLOSED_GROUP]
	@PhaseID CHAR(3)
,	@PeriodOrWeek CHAR(1)
,	@Period char(7)
,	@PicDate CHAR(6)
,	@SrSvcManager VARCHAR(100)
,	@SvcManager VARCHAR(100)
,	@YearToDate Bit
AS

	DECLARE @StartDate datetime
	DECLARE @EndDate datetime
	
	IF @PeriodOrWeek = 'P' 
	-- Period
	BEGIN
		DECLARE @FiscalPeriod char(2)
		DECLARE @FiscalYear char(4)
		SET @FiscalPeriod = RIGHT(@Period,2)
		SET @FiscalYear = '20' + LEFT(@Period,2)
	
		SELECT @StartDate = MIN(WeekOfDate), @EndDate = MAX(WeekEndDate) 
		FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE FiscalYear = CAST(@FiscalYear AS INT) AND FiscalPeriod = CAST(@FiscalPeriod AS INT)
	END
	ELSE
	-- Week
	BEGIN
		DECLARE @PicWeek char(2)
		DECLARE @PicYear char(4)
		SET @PicWeek = RIGHT(@PicDate,2)
		SET @PicYear = '20' + LEFT(@PicDate,2)
	
		SELECT @StartDate = WeekOfDate, @EndDate = WeekEndDate 
		FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
	END
	
	--Override the @StartDate if we are using YearToDate
	IF @YearToDate = 1 
	BEGIN
		SET @StartDate = '1/1/' + cast(year(@EndDate) as varchar)
	END
	
	-----------------------------------------------------------------
	-- Report Data
	-----------------------------------------------------------------
	SELECT
			RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) TaskID
		,	RTRIM(cft_PIG_GROUP_ROLLUP.MasterGroup) MasterGroup
		,	RTRIM(cft_PIG_GROUP_ROLLUP.SiteContactID) SiteContactID
		,	cft_PIG_GROUP_ROLLUP.PigFlowID
		,	cft_PIG_GROUP_ROLLUP.ActCloseDate
		,	cft_PIG_GROUP_ROLLUP.ActStartDate
		,	RTRIM(cft_PIG_GROUP_ROLLUP.SrSvcManager) SrSvcManager
		,	RTRIM(cft_PIG_GROUP_ROLLUP.SvcManager) SvcManager
		,	RTRIM(CASE WHEN (cft_PIG_GROUP_ROLLUP.BarnNbr IS NOT NULL)
				THEN 'Barn ' + RTRIM(cft_PIG_GROUP_ROLLUP.BarnNbr)
				ELSE 'Site'
			END) BarnNbr
		,	RTRIM(cft_PIG_GROUP_ROLLUP.Description) Description
		,	RTRIM(cft_PIG_GROUP_ROLLUP.PodDescription) PodDescription
		,	cft_PIG_GROUP_ROLLUP.HeadStarted
		,	cft_PIG_GROUP_ROLLUP.Mortality
		,	cft_PIG_GROUP_ROLLUP.AverageDailyGain
		,	cft_PIG_GROUP_ROLLUP.FeedToGain
		,	cft_PIG_GROUP_ROLLUP.LivePigDays
		,   AdjAverageDailyGain = 
		Cast(case 
			when @PhaseID = 'NUR'
				then case when isnull(cft_PIG_GROUP_ROLLUP.TotalHeadProduced,0) = 0 then 0 
				else case when (cft_PIG_GROUP_ROLLUP.LivePigDays / cft_PIG_GROUP_ROLLUP.TotalHeadProduced) <= 43
				then ((43 - (cft_PIG_GROUP_ROLLUP.LivePigDays / cft_PIG_GROUP_ROLLUP.TotalHeadProduced)) * 0.015) + cft_PIG_GROUP_ROLLUP.AverageDailyGain
				else cft_PIG_GROUP_ROLLUP.AverageDailyGain - (((cft_PIG_GROUP_ROLLUP.LivePigDays / cft_PIG_GROUP_ROLLUP.TotalHeadProduced) - 43) * 0.015) end end 
			
			when @PhaseID = 'FIN'
				then case when case when isnull(cft_PIG_GROUP_ROLLUP.TotalPigDays,0) <> 0
				then isnull(cft_PIG_GROUP_ROLLUP.WeightGained,0) / cft_PIG_GROUP_ROLLUP.TotalPigDays
				else 0 end > 0 then isnull(cft_PIG_GROUP_ROLLUP.WeightGained,0) / cft_PIG_GROUP_ROLLUP.TotalPigDays
				+ ((50 - case when isnull(cft_PIG_GROUP_ROLLUP.TransferIn_Qty,0) <> 0
				then isnull(cft_PIG_GROUP_ROLLUP.TransferIn_Wt,0) / cft_PIG_GROUP_ROLLUP.TransferIn_Qty else 0 end) * 0.005)
				+ ((270 - case when (isnull(cft_PIG_GROUP_ROLLUP.TotalHeadProduced,0) + isnull(cft_PIG_GROUP_ROLLUP.TransportDeath_Qty,0)) <> 0
				then (isnull(cft_PIG_GROUP_ROLLUP.Prim_Wt,0) + isnull(cft_PIG_GROUP_ROLLUP.Cull_Wt,0) + isnull(cft_PIG_GROUP_ROLLUP.DeadPigsToPacker_Wt,0) + isnull(cft_PIG_GROUP_ROLLUP.TransferToTailender_Wt,0) + isnull(cft_PIG_GROUP_ROLLUP.TransferOut_Wt,0) + isnull(cft_PIG_GROUP_ROLLUP.TransportDeath_Wt,0)) / (isnull(cft_PIG_GROUP_ROLLUP.TotalHeadProduced,0) + isnull(cft_PIG_GROUP_ROLLUP.TransportDeath_Qty,0))
				else 0 end) * 0.001) else 0 end 
			else case when isnull(cft_PIG_GROUP_ROLLUP.TotalPigDays,0) <> 0
				then isnull(cft_PIG_GROUP_ROLLUP.WeightGained,0) / cft_PIG_GROUP_ROLLUP.TotalPigDays
				else 0 end
		end as Numeric(14,3))
		,	cft_PIG_GROUP_ROLLUP.AdjFeedToGain
		,	cft_PIG_GROUP_ROLLUP.AverageDailyFeedIntake
		,	cft_PIG_GROUP_ROLLUP.MedicationCostPerHead
		,	ISNULL(cft_PIG_GROUP_ROLLUP.TransferIn_Wt,0) TransferIn_Wt
		,	cft_PIG_GROUP_ROLLUP.TransferIn_Qty
		,	CAST(cft_PIG_GROUP_ROLLUP.AveragePurchase_Wt AS NUMERIC(14,1)) AveragePurchase_Wt
		,	cft_PIG_GROUP_ROLLUP.Prim_Wt
		,	cft_PIG_GROUP_ROLLUP.Cull_Wt
		,	cft_PIG_GROUP_ROLLUP.Top_Wt
		,	cft_PIG_GROUP_ROLLUP.DeadPigsToPacker_Wt
		,	cft_PIG_GROUP_ROLLUP.TransferToTailender_Wt
		,	cft_PIG_GROUP_ROLLUP.TransferOut_Wt
		,	cft_PIG_GROUP_ROLLUP.TransportDeath_Wt
		,	cft_PIG_GROUP_ROLLUP.TotalHeadProduced
		,	cft_PIG_GROUP_ROLLUP.TransportDeath_Qty
		,	CAST(cft_PIG_GROUP_ROLLUP.AverageOut_Wt AS NUMERIC(14,1)) AverageOut_Wt
		,	cft_PIG_GROUP_ROLLUP.DeadPigsToPacker_Qty
		,	cft_PIG_GROUP_ROLLUP.DeadPigsToPacker_Pct
		,	cft_PIG_GROUP_ROLLUP.Prim_Qty
		,	cft_PIG_GROUP_ROLLUP.Cull_Qty
		,	cft_PIG_GROUP_ROLLUP.Cull_Pct
		,	cft_PIG_GROUP_ROLLUP.Top_Qty
		,	cft_PIG_GROUP_ROLLUP.PigDeath_Qty
		,	cft_PIG_GROUP_ROLLUP.TransferToTailender_Qty
		,	cft_PIG_GROUP_ROLLUP.Tailender_Pct
		,	cft_PIG_GROUP_ROLLUP.NoValue_Pct
		,	cft_PIG_GROUP_ROLLUP.WeightGained
		,	cft_PIG_GROUP_ROLLUP.TotalPigDays
		,	cft_PIG_GROUP_ROLLUP.TotalCapacityDays
		,	cft_PIG_GROUP_ROLLUP.Feed_Qty
		,	cft_PIG_GROUP_ROLLUP.MedicationCost
		,	cft_PIG_GROUP_ROLLUP.HeadSold
		,	(cast(cft_PIG_GROUP_ROLLUP.Prim_Qty as numeric(10,2)) / cast(cft_PIG_GROUP_ROLLUP.HeadStarted as numeric(10,2))) * 100 Primary_Pct
		,	cft_PIG_GROUP_ROLLUP.AverageMarket_Wt
		,	cft_PIG_GROUP_ROLLUP.EmptyCapacityDays
		,	cft_PIG_GROUP_ROLLUP.HeadCapacity
		,	cft_PIG_GROUP_ROLLUP.AverageEmptyDays
		,	cft_PIG_GROUP_ROLLUP.PigCapacityDays
		,	cft_PIG_GROUP_ROLLUP.AverageDaysInGroup
		,	cft_PIG_GROUP_ROLLUP.Utilization
		,	cft_PIG_GROUP_ROLLUP.VaccinationCost
		,	cft_PIG_GROUP_ROLLUP.VaccinationCostPerHeadSold
		,	cft_PIG_GROUP_ROLLUP.FeedCost
		,	cft_PIG_GROUP_ROLLUP.FeedCostPerHundredGain
		,   Contact.ContactName
		,	cft_PIG_GROUP_BASE_SOURCE.BaseSource BaseSource
	FROM dbo.cft_PIG_GROUP_ROLLUP cft_PIG_GROUP_ROLLUP(NOLOCK)
	inner join [$(SolomonApp)].dbo.cftpiggroup cpp on cft_PIG_GROUP_ROLLUP.TaskID=cpp.TaskID and cpp.PigProdPodID != 53 -- Ignore SBF groups
	LEFT JOIN [$(CentralData)].dbo.Contact Contact (NOLOCK)
		ON cft_PIG_GROUP_ROLLUP.SiteContactID = Contact.ContactID
	LEFT JOIN  dbo.cft_PIG_GROUP_BASE_SOURCE cft_PIG_GROUP_BASE_SOURCE (NOLOCK)
		ON cft_PIG_GROUP_BASE_SOURCE.PigGroupID = SUBSTRING(cft_PIG_GROUP_ROLLUP.TaskID,3,10)
	WHERE	cft_PIG_GROUP_ROLLUP.ActCloseDate BETWEEN @StartDate AND @EndDate
	AND	Phase = @PhaseID
	AND	RTRIM(cft_PIG_GROUP_ROLLUP.TaskID) LIKE 'PG%'
	AND RTRIM(SrSvcManager) LIKE RTRIM(@SrSvcManager)
	AND RTRIM(SvcManager) LIKE RTRIM(@SvcManager)
	ORDER BY MasterGroup, LEFT(cft_PIG_GROUP_ROLLUP.TaskID,1) DESC, TaskID

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_CLOSED_GROUP] TO [db_sp_exec]
    AS [dbo];

