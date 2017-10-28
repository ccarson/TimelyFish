


CREATE PROCEDURE [dbo].[cfp_REPORT_SITE_CLOSEOUT_DEV]
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
-- Find PigFlowID for top 10 % 
-----------------------------------------------------------------

DECLARE @PigFlowID int

SELECT @PigFlowID = mgr.PigFlowID FROM  dbo.cft_PIG_MASTER_GROUP_ROLLUP mgr (NOLOCK)
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo dw (NOLOCK)
	on mgr.ActCloseDate = dw.DayDate 
	WHERE @SiteContactID = mgr.SiteContactID 
	AND @PhaseID = mgr.Phase
	AND @PicDate = dw.PICYear_Week

-----------------------------------------------------------------
-- Find the date range to compare top 10 % range (13 week span)
-----------------------------------------------------------------
DECLARE @Top10StartDate datetime
DECLARE @Top10EndDate datetime

SELECT @Top10EndDate = @PicEndDate
SELECT @Top10StartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) 
	WHERE --PicYear = CAST(@PicYear AS INT) --AND PicWeek = (CAST(@PicWeek AS INT) -3)
	DATEADD(wk,-13,@PicStartDate) BETWEEN WeekOfDate AND WeekEndDate
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
DECLARE @DOTDIY NUMERIC(5,2)
DECLARE @Mort NUMERIC(5,2)
-----------------------------------------------------------------
-- Average Daily Gain
-----------------------------------------------------------------
--SELECT @ADG =
--CAST(SUM(ADG.WeightGained)/SUM(ADG.TotalPigDays) AS NUMERIC(5,2))
--FROM
--(SELECT
--TOP 10 PERCENT
--            AverageDailyGain = case when isnull(TotalPigDays,0) <> 0
--                  then isnull(WeightGained,0) / TotalPigDays
--                  else 0
--            end
--,	WeightGained
--,	TotalPigDays
--FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
--AND Phase = @PhaseID
--AND PigFlowID = @PigFlowID 
--AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
--AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
--ORDER BY
--case when isnull(TotalPigDays,0) <> 0
--      then isnull(WeightGained,0) / TotalPigDays
--      else 0
--end DESC) ADG

-----------------------------------------------------------------
-- Adj Average Daily Gain
-----------------------------------------------------------------
SELECT @ADG = AVG(CAST(ADG.AdjAverageDailyGain AS NUMERIC(5,2)))
FROM
(SELECT
TOP 10 PERCENT
            AdjAverageDailyGain =
            case
                  when Phase = 'NUR'
                        then case when isnull(TotalHeadProduced,0) = 0 then 0 
                        else case when (LivePigDays / TotalHeadProduced) <= 43
                        then ((43 - (LivePigDays / TotalHeadProduced)) * 0.015) + AverageDailyGain
                        else AverageDailyGain - (((LivePigDays / TotalHeadProduced) - 43) * 0.015) end end
                  when Phase = 'FIN'
                        then case when AverageDailyGain > 0 then AverageDailyGain
                        + ((50 - AveragePurchase_Wt) * 0.005)
                        + ((270 - AverageOut_Wt) * 0.001) else 0 end 
                  when Phase = 'WTF'
                        then case when AverageDailyGain > 0 then AverageDailyGain
                        + ((270 - AverageOut_Wt) * 0.001) else 0 end  
                  else AverageDailyGain
            end
,	WeightGained
,	TotalPigDays
FROM  dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
AND Phase = @PhaseID
AND PigFlowID = @PigFlowID 
--AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
--AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
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
AND PigFlowID = @PigFlowID 
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
AND PigFlowID = @PigFlowID 
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
-- DOTDIY
-----------------------------------------------------------------
SELECT @DOTDIY = Cast(Sum(DotDiy.DotDiy_Qty) as numeric(14,2))/Cast(Sum(DotDiy.HeadStarted) as numeric(14,2))*100


FROM
(SELECT TOP 10 PERCENT
	DOTDIY =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(DeadOnTruck_Qty+DeadInYard_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	DOTDIY_Qty = DeadOnTruck_Qty+DeadInYard_Qty
,	HeadStarted		
FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE ActCloseDate BETWEEN @PICStartDate AND @PICEndDate
AND Phase = @PhaseID
AND HeadStarted >= 500
ORDER BY
case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(DeadOnTruck_Qty+DeadInYard_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end) DOTDIY

-----------------------------------------------------------------
-- Mortality
-----------------------------------------------------------------
--DECLARE @MGHeadStarted int
--DECLARE @MasterGroup char(10)
--SELECT	@MasterGroup = MasterGroup
--,	@MGHeadStarted = HeadStarted 
--FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
--WHERE	CAST(SiteContactID AS INT) = @SiteContactID
--AND	MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
--AND	Phase = @PhaseID
--AND PigFlowId = @PigFlowID 
--AND	TaskID LIKE 'MG%'

--DECLARE @PodDescription CHAR(30)
--DECLARE @PodHeadStarted NUMERIC(14,2)
--DECLARE @PodTop10Calc NUMERIC(14,2)
--SET @PodTop10Calc = 0

--DECLARE Pod_Cursor CURSOR FOR
--SELECT DISTINCT RTRIM(PodDescription) PodDescription 
--FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS
--WHERE MasterGroup = @MasterGroup
--AND TaskID NOT LIKE 'MG%'

--OPEN Pod_Cursor
--FETCH NEXT FROM Pod_Cursor INTO @PodDescription

--WHILE @@FETCH_STATUS = 0
--BEGIN
--	--reconfigure the weights for mortality
--	IF @PhaseID = 'NUR'
--	BEGIN
--		SELECT @MinBegWt = 
--			CASE WHEN AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 2) < (AVG(AveragePurchase_Wt) - 3)
--				THEN AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 2)
--				ELSE AVG(AveragePurchase_Wt) - 3
--			END,

--			@MaxBegWt = 
--			CASE WHEN AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 2) > (AVG(AveragePurchase_Wt) + 3)
--				THEN AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 2)
--				ELSE AVG(AveragePurchase_Wt) + 3
--			END,

--			@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

--			@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 1.5)
--		FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--		WHERE Phase = @PhaseID
--		AND PigFlowID = @PigFlowID 
--		--AND RTRIM(PodDescription) = @PodDescription
--		AND ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
--	END
--	ELSE
--	BEGIN
--		SELECT @MinBegWt = AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 1.5),

--			@MaxBegWt = AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 1.5),

--			@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

--			@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 2)
--		FROM dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--		WHERE Phase = @PhaseID
--		AND PigFlowID = @PigFlowID 
--		--AND RTRIM(PodDescription) = @PodDescription
--		AND ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
--	END


--	SELECT @PodHeadStarted = cast(x.HeadStarted as numeric(14,2)) / cast(@MGHeadStarted as numeric(14,2))
--	FROM (SELECT SUM(HeadStarted) HeadStarted 
--		FROM dbo.cfv_PIG_GROUP_ROLLUP_DETAILS 
--		WHERE MasterGroup = @MasterGroup
--		AND TaskID LIKE 'PG%'
--		AND RTRIM(PodDescription) = RTRIM(@PodDescription)) x

--	-- TOP 10 % BY POD
--	SELECT @Mort = CAST((CAST(SUM(ISNULL(Mort.PigDeath_Qty,0)) AS NUMERIC(14,2)) / CAST(SUM(Mort.HeadStarted) AS NUMERIC(14,2))) * 100 AS NUMERIC(5,2))
--	FROM
--	(SELECT TOP 10 PERCENT
--		Mortality =
--			case when isnull(HeadStarted,0) <> 0
--				then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
--				else 0
--			end
--	,	PigDeath_Qty
--	,	HeadStarted
--	FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
--	WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
--	AND Phase = @PhaseID
--	AND PigFlowID = @PigFlowID 
--	AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
--	AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
--	AND RTRIM(PodDescription) = @PodDescription
--	ORDER BY
--	case when isnull(HeadStarted,0) <> 0
--		then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
--		else 0
--	end) Mort

--	SET @PodTop10Calc = @PodTop10Calc + (@PodHeadStarted * cast(@Mort as numeric(14,2)))

--FETCH NEXT FROM Pod_Cursor INTO @PodDescription
--END
--CLOSE Pod_Cursor
--DEALLOCATE Pod_Cursor

-----------------------------------------------------------------
-- Mortality (updated 08/12)
-----------------------------------------------------------------
SELECT @MORT = Cast(Sum(Mort.PigDeath_Qty) as numeric(14,2))/Cast(Sum(Mort.HeadStarted) as numeric(14,2))*100
FROM
(SELECT TOP 10 PERCENT
	MORT =
		case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	PigDeath_Qty
,	HeadStarted		
FROM	dbo.cft_PIG_GROUP_ROLLUP (NOLOCK)
WHERE ActCloseDate BETWEEN @Top10StartDate AND @Top10EndDate
AND Phase = @PhaseID
AND PigFlowID = @PigFlowID 
AND AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
AND AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
ORDER BY
case when isnull(HeadStarted,0) <> 0
			then (cast(isnull(PigDeath_Qty,0) as numeric(14,2)) / cast(HeadStarted as numeric(14,2))) * 100
			else 0
		end) MORT

-----------------------------------------------------------------
-- % Head Weighed Temp Table
-----------------------------------------------------------------

	Declare @LW Table
	(PigGroupID char(10)
	,MasterGroup char(10)
	,Qty int
	,LoadWeighed int)
	
	Insert Into @LW

	Select 
	tr.SourcePigGroupID as 'PigGroupID',
	mg.MasterGroup,
	Sum(tr.Qty) as 'Qty',
	tr.LoadWeighed

	from (

	Select 
	SourcePigGroupID,
	Case when RecountRequired = 1 then Sum(RecountQty) else Sum(DestFarmQty) end as 'Qty',
	LoadWeighed  
	From [$(SolomonApp)].dbo.cftPMTranspRecord
	Group by
	SourcePigGroupID,
	RecountRequired, 
	LoadWeighed) tr

	left join (Select Distinct CF03 as 'MasterGroup', PigGroupID 
	From [$(SolomonApp)].dbo.cftPigGroup) mg
	on tr.SourcePigGroupID = mg.PigGroupID 

	Group by 
	tr.SourcePigGroupID,
	mg.MasterGroup, 
	tr.LoadWeighed

	Order by
	tr.SourcePigGroupID 

-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------
SELECT
	RTRIM(pgr.TaskID) TaskID
,	RTRIM(pgr.MasterGroup) MasterGroup
,	RTRIM(pgr.SiteContactID) SiteContactID
,	pgr.PigFlowID
,	pf.PigFlowDescription
,	pgr.ActCloseDate
,	pgr.ActStartDate
,	RTRIM(pgr.SrSvcManager) SrSvcManager
,	RTRIM(pgr.SvcManager) SvcManager
,	RTRIM(CASE WHEN (pgr.BarnNbr IS NOT NULL)
		THEN 'Barn ' + RTRIM(pgr.BarnNbr)
		ELSE 'Site'
	END) BarnNbr
,	RTRIM(pgr.Description) Description
,	RTRIM(pgr.PodDescription) PodDescription
,	pgr.HeadStarted
,	pgr.TotalHeadProduced
,	pgr.Mortality
,	pgr.AverageDailyGain
,	pgr.AdjAverageDailyGain
,	pgr.FeedToGain
,	pgr.AdjFeedToGain
,	pgr.AverageDailyFeedIntake
,	pgr.MedicationCostPerHead
,	CAST(pgr.AveragePurchase_Wt AS NUMERIC(14,1)) AveragePurchase_Wt
,	CAST(pgr.AverageOut_Wt AS NUMERIC(14,1)) AverageOut_Wt
,	pgr.DeadPigsToPacker_Pct
,	pgr.Cull_Pct
,	pgr.Tailender_Pct
,	Primary_Pct =
		case when isnull(pgr.HeadStarted,0) <> 0
			then (cast(isnull(pgr.Prim_Qty,0) as numeric(14,2)) / cast(pgr.HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	DOTDIY_Pct =
		case when isnull(pgr.HeadStarted,0) <> 0
			then (cast(isnull(pgr.DeadOnTruck_Qty+pgr.DeadInYard_Qty,0) as numeric(14,2)) / cast(pgr.HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	Condemned_Pct =
		case when isnull(pgr.HeadStarted,0) <> 0
			then (cast(isnull(pgr.CondemnedByPacker_Qty+pgr.Condemned_Qty,0) as numeric(14,2)) / cast(pgr.HeadStarted as numeric(14,2))) * 100
			else 0
		end
,	pgr.NoValue_Pct
,	pgr.PigDeath_Qty
,	pgr.TransferOut_Qty
,	pgr.TransferToTailender_Qty
,	pgr.Prim_Qty
,	pgr.Cull_Qty
,	pgr.TransportDeath_Qty
,	DOTDIY = pgr.DeadOnTruck_Qty+pgr.DeadInYard_Qty
,	Condemned = pgr.CondemnedByPacker_Qty+pgr.Condemned_Qty
,	pgr.InventoryAdjustment_Qty
,	pgtw.ActQty as 'PGHead'
,	pglw.ActQty as 'PGHeadWeighed'
,	@ADG ADGTopTenPct
--,	@FG FGTopTenPct
,	@AFG AdjFGTopTenPct
,	@ADFI ADFITopTenPct
,	@DOTDIY DOTDIYTopTenPct
,	@MORT MortTopTenPct
--,	@PodTop10Calc MortTopTenPct
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,1) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,11) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,28) 
--	END ADGTargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,2) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,12) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,29) 
--	END FeedToGainTargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,3) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,13) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,30) 
--	END MortalityTargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,6) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,14) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,31) 
--	END ADFITargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,7) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,15) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,32) 
--	END DeadToPackerPctTargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,8) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,16) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,33) 
--	END CullPctTargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,9) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,17) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,34) 
--    END TailEnderPctTargetLine
--,   CASE 
--        WHEN @PhaseID = 'NUR' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,10) 
--        WHEN @PhaseID = 'FIN' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,18) 
--        WHEN @PhaseID = 'WTF' THEN [$(CFApp_PigManagement)].dbo.cffn_GET_PIG_GROUP_TARGET_LINE(MasterActStartDate,PigFlowID,35) 
--	END NoValuePctTargetLine
FROM  dbo.cfv_PIG_GROUP_ROLLUP_DETAILS pgr
left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
on pgr.PigFlowID = pf.PigFlowID 
left join (Select PigGroupID, Sum(Qty) as 'ActQty' from @LW 
where LoadWeighed = 1 Group by PigGroupID) pglw
on right(rtrim(pgr.TaskID),5) = pglw.PigGroupID
left join (Select PigGroupID, Sum(Qty) as 'ActQty' from @LW
Group by PigGroupID) pgtw
on right(rtrim(pgr.TaskID),5) = pgtw.PigGroupID
--left join (Select MasterGroup, Sum(Qty) as 'ActQty' from @LW 
--where LoadWeighed = 1 Group by MasterGroup) mglw
--on pgr.MasterGroup = mglw.MasterGroup
--left join (Select MasterGroup, Sum(Qty) as 'ActQty' from @LW
--Group by MasterGroup) mgtw
--on pgr.MasterGroup = mgtw.MasterGroup
WHERE	CAST(pgr.SiteContactID AS INT) = @SiteContactID
AND	pgr.MasterActCloseDate BETWEEN @PicStartDate AND @PicEndDate
AND	pgr.Phase = @PhaseID
--	RTRIM(MasterGroup) = '26570'
ORDER BY pgr.MasterGroup, LEFT(pgr.TaskID,1) DESC, pgr.TaskID

--PRINT 'PicStartDate = ' + cast(@PicStartDate as varchar)
--PRINT 'PicEndDate = ' + cast(@PicEndDate as varchar)




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_REPORT_SITE_CLOSEOUT_DEV] TO [db_sp_exec]
    AS [dbo];

