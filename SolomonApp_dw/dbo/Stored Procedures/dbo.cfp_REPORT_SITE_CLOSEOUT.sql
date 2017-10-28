

CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_CLOSEOUT]
	@PhaseID CHAR(3)
,	@SiteContactID int
,	@PicDate CHAR(6)
AS

DECLARE @PicYear char(4)
DECLARE @PicWeek char(2)
DECLARE @PicStartDate datetime
DECLARE @PicEndDate datetime
SET @PicYear = '20' + LEFT(@PicDate,2)
SET @PicWeek = RIGHT(@PicDate,2)

SELECT @PicStartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
SELECT @PicEndDate = WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)



-----------------------------------------------------------------
-- Find the date range to compare top 10 % range (4 week span)
-----------------------------------------------------------------
DECLARE @Top10StartDate datetime
DECLARE @Top10EndDate datetime

SELECT @Top10EndDate = @PicEndDate
SELECT @Top10StartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
	WHERE --PicYear = CAST(@PicYear AS INT) --AND PicWeek = (CAST(@PicWeek AS INT) -3)
	DATEADD(wk,-3,@PicStartDate) BETWEEN WeekOfDate AND WeekEndDate
-----------------------------------------------------------------


-----------------------------------------------------------------
-- Get the boundaries of which to include for top 10 %
-----------------------------------------------------------------
DECLARE @MinBegWt NUMERIC(14,2)
DECLARE @MaxBegWt NUMERIC(14,2)
DECLARE @MinEndWt NUMERIC(14,2)
DECLARE @MaxEndWt NUMERIC(14,2)

IF @PhaseID = 'NUR'
BEGIN
	SELECT @MinBegWt = 
		CASE WHEN AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 2) < (AVG(AveragePurchase_Wt) - 3)
			THEN AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 2)
			ELSE AVG(AveragePurchase_Wt) - 3
		END,

		@MaxBegWt = 
		CASE WHEN AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 2) > (AVG(AveragePurchase_Wt) + 3)
			THEN AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 2)
			ELSE AVG(AveragePurchase_Wt) + 3
		END,

		@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

		@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 1.5)
	FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
	WHERE Phase = @PhaseID
	AND ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
END
ELSE
BEGIN
	SELECT @MinBegWt = AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 1.5),

		@MaxBegWt = AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 1.5),

		@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

		@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 2)
	FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
	WHERE Phase = @PhaseID
	AND ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
END
-----------------------------------------------------------------



DECLARE @ADG NUMERIC(5,2)
DECLARE @FG NUMERIC(5,2)
DECLARE @AFG NUMERIC(5,2)
DECLARE @ADFI NUMERIC(5,2)
DECLARE @Mort NUMERIC(5,2)
-----------------------------------------------------------------
-- Average Daily Gain
-----------------------------------------------------------------
SELECT @ADG =
CAST(SUM(ADG.WeightGained)/SUM(ADG.TotalPigDays) AS NUMERIC(5,2))
FROM
(SELECT
TOP 10 PERCENT
            AverageDailyGain = case when isnull(TotalPigDays,0) <> 0
                  then isnull(WeightGained,0) / TotalPigDays
                  else 0
            end
,	WeightGained
,	TotalPigDays
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
AND Phase = @PhaseID
AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
ORDER BY
case when isnull(TotalPigDays,0) <> 0
      then isnull(WeightGained,0) / TotalPigDays
      else 0
end DESC) ADG

-------------------------------------------------------------------
---- Feed To Gain
-------------------------------------------------------------------
--SELECT @FG = CAST(SUM(ISNULL(FG.Feed_Qty,0)) / SUM(FG.WeightGained) AS NUMERIC(5,2))
--FROM
--(SELECT TOP 10 PERCENT
--	FeedToGain =
--		case when isnull(WeightGained,0) <> 0
--			then isnull(Feed_Qty,0) / WeightGained
--			else 0
--		end
--,	Feed_Qty
--,	WeightGained		
--FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
--AND Phase = @PhaseID
--AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
--AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
--ORDER BY
--case when isnull(WeightGained,0) <> 0
--	then isnull(Feed_Qty,0) / WeightGained
--	else 0
--end) FG

-----------------------------------------------------------------
-- Adj Feed To Gain
-----------------------------------------------------------------
SELECT @AFG = AVG(CAST(AFG.AdjFeedToGain AS NUMERIC(5,2)))
FROM
(SELECT TOP 10 PERCENT
	AdjFeedToGain =
		case 
			when @PhaseID = 'NUR'
				then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
			when @PhaseID = 'FIN'
				then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
			else FeedToGain
		end
,	Feed_Qty
,	WeightGained		
FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
AND Phase = @PhaseID
AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
ORDER BY
case 
	when @PhaseID = 'NUR'
		then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
	when @PhaseID = 'FIN'
		then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
	else FeedToGain
end) AFG


-----------------------------------------------------------------
-- Average Daily Feed Intake
-----------------------------------------------------------------
SELECT @ADFI = CAST(SUM(ISNULL(ADFI.Feed_Qty,0)) / SUM(ADFI.TotalPigDays) AS NUMERIC(5,2))
FROM
(SELECT TOP 10 PERCENT
	ADFI =
		case when isnull(TotalPigDays,0) <> 0
			then isnull(Feed_Qty,0) / TotalPigDays
			else 0
		end
,	Feed_Qty
,	TotalPigDays		
FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
AND Phase = @PhaseID
AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
-- this order by causes us to use the same data set for top 10% as the Adj Feed To Gain's group above
ORDER BY
case 
	when @PhaseID = 'NUR'
		then FeedToGain + ((50 - AverageOut_Wt) * 0.005)
	when @PhaseID = 'FIN'
		then FeedToGain + ((50 - AveragePurchase_Wt) * 0.005) + ((270 - AverageOut_Wt) * 0.005)
	else FeedToGain
end) ADFI

-----------------------------------------------------------------
-- Mortality
-----------------------------------------------------------------
DECLARE @MGHeadStarted int
DECLARE @MasterGroup char(10)
SELECT	@MasterGroup = MasterGroup
,	@MGHeadStarted = HeadStarted 
FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
WHERE	CAST(SiteContactID AS INT) = @SiteContactID
AND	MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
AND	Phase = @PhaseID
AND	TaskID LIKE 'MG%'

DECLARE @PodDescription CHAR(30)
DECLARE @PodHeadStarted NUMERIC(14,2)
DECLARE @PodTop10Calc NUMERIC(14,2)
SET @PodTop10Calc = 0

DECLARE Pod_Cursor CURSOR FOR
SELECT DISTINCT RTRIM(PodDescription) PodDescription 
FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
WHERE MasterGroup = @MasterGroup
AND TaskID NOT LIKE 'MG%'

OPEN Pod_Cursor
FETCH NEXT FROM Pod_Cursor INTO @PodDescription

WHILE @@FETCH_STATUS = 0
BEGIN
	--reconfigure the weights for mortality
	IF @PhaseID = 'NUR'
	BEGIN
		SELECT @MinBegWt = 
			CASE WHEN AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 2) < (AVG(AveragePurchase_Wt) - 3)
				THEN AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 2)
				ELSE AVG(AveragePurchase_Wt) - 3
			END,

			@MaxBegWt = 
			CASE WHEN AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 2) > (AVG(AveragePurchase_Wt) + 3)
				THEN AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 2)
				ELSE AVG(AveragePurchase_Wt) + 3
			END,

			@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

			@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 1.5)
		FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
		WHERE Phase = @PhaseID
		AND RTRIM(PodDescription) = @PodDescription
		AND ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
	END
	ELSE
	BEGIN
		SELECT @MinBegWt = AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 1.5),

			@MaxBegWt = AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 1.5),

			@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

			@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 2)
		FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
		WHERE Phase = @PhaseID
		AND RTRIM(PodDescription) = @PodDescription
		AND ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
	END


	SELECT @PodHeadStarted = cast(x.HeadStarted as numeric(14,2)) / cast(@MGHeadStarted as numeric(14,2))
	FROM (SELECT SUM(HeadStarted) HeadStarted 
		FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS 
		WHERE MasterGroup = @MasterGroup
		AND TaskID LIKE 'PG%'
		AND RTRIM(PodDescription) = RTRIM(@PodDescription)) x

	-- TOP 10 % BY POD
	SELECT @Mort = CAST((CAST(SUM(ISNULL(Mort.PigDeath_Qty,0)) AS NUMERIC(14,2)) / CAST(SUM(Mort.HeadStarted) AS NUMERIC(14,2))) * 100 AS NUMERIC(5,2))
	FROM
	(SELECT TOP 10 PERCENT
		Mortality =
			case when isnull(HeadStarted,0) <> 0
				then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
				else 0
			end
	,	PigDeath_Qty
	,	HeadStarted
	FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
	WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
	AND Phase = @PhaseID
	AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
	AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
	AND RTRIM(PodDescription) = @PodDescription
	ORDER BY
	case when isnull(HeadStarted,0) <> 0
		then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
		else 0
	end) Mort

	SET @PodTop10Calc = @PodTop10Calc + (@PodHeadStarted * cast(@Mort as numeric(14,2)))

FETCH NEXT FROM Pod_Cursor INTO @PodDescription
END
CLOSE Pod_Cursor
DEALLOCATE Pod_Cursor


-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------
SELECT
	RTRIM(TaskID) TaskID
,	RTRIM(MasterGroup) MasterGroup
,	RTRIM(SiteContactID) SiteContactID
,	PigFlowID
,	ActCloseDate
,	ActStartDate
,	RTRIM(SrSvcManager) SrSvcManager
,	RTRIM(SvcManager) SvcManager
,	RTRIM(CASE WHEN (BarnNbr IS NOT NULL)
		THEN 'Barn ' + RTRIM(BarnNbr)
		ELSE 'Site'
	END) BarnNbr
,	RTRIM(Description) Description
,	RTRIM(PodDescription) PodDescription
,	HeadStarted
,	TotalHeadProduced
,	Mortality
,	AverageDailyGain
,	FeedToGain
,	AdjFeedToGain
,	AverageDailyFeedIntake
,	MedicationCostPerHead
,	CAST(AveragePurchase_Wt AS NUMERIC(14,1)) AveragePurchase_Wt
,	CAST(AverageOut_Wt AS NUMERIC(14,1)) AverageOut_Wt
,	DeadPigsToPacker_Pct
,	Cull_Pct
,	Tailender_Pct
,	NoValue_Pct
,	InventoryAdjustment_Qty
,	@ADG ADGTopTenPct
--,	@FG FGTopTenPct
,	@AFG AdjFGTopTenPct
,	@ADFI ADFITopTenPct
,	@PodTop10Calc MortTopTenPct
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,1) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,11) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,28) 
	END ADGTargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,2) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,12) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,29) 
	END FeedToGainTargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,3) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,13) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,30) 
	END MortalityTargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,6) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,14) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,31) 
	END ADFITargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,7) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,15) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,32) 
	END DeadToPackerPctTargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,8) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,16) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,33) 
	END CullPctTargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,9) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,17) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,34) 
    END TailEnderPctTargetLine
,   CASE 
        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,10) 
        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,18) 
        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,35) 
	END NoValuePctTargetLine
FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
WHERE	CAST(SiteContactID AS INT) = @SiteContactID
AND	MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
AND	Phase = @PhaseID
--	RTRIM(MasterGroup) = '26570'
ORDER BY MasterGroup, LEFT(TaskID,1) DESC, TaskID

--PRINT 'PicStartDate = ' + cast(@PicStartDate as varchar)
--PRINT 'PicEndDate = ' + cast(@PicEndDate as varchar)



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CLOSEOUT] TO [db_sp_exec]
    AS [dbo];

