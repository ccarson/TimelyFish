

CREATE PROCEDURE [dbo].[cfp_MONTHLY_NURSERY_REPORT_SYSTEM]
	@PhaseID CHAR(3)
,	@StartPeriod datetime
,	@EndPeriod datetime
,	@SysStartPeriod datetime
AS

-----------------------------------------------------------------
-- Get the boundaries of which to include for top 25 %
-----------------------------------------------------------------
DECLARE @MinBegWt NUMERIC(14,2)
DECLARE @MaxBegWt NUMERIC(14,2)
DECLARE @MinEndWt NUMERIC(14,2)
DECLARE @MaxEndWt NUMERIC(14,2)

IF @PhaseID = 'NUR'
BEGIN
	SELECT 
	@MinBegWt = 
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
	FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
	WHERE Phase = @PhaseID
	AND ActCloseDate BETWEEN @StartPeriod AND @EndPeriod
END
ELSE
BEGIN
	SELECT @MinBegWt = AVG(AveragePurchase_Wt) - (STDEV(AveragePurchase_Wt) * 1.5),

		@MaxBegWt = AVG(AveragePurchase_Wt) + (STDEV(AveragePurchase_Wt) * 1.5),

		@MinEndWt = AVG(AverageOut_Wt) - (STDEV(AverageOut_Wt) * 1.5),

		@MaxEndWt = AVG(AverageOut_Wt) + (STDEV(AverageOut_Wt) * 2)
	FROM dbo.cft_PIG_MASTER_GROUP_ROLLUP (NOLOCK)
	WHERE Phase = @PhaseID
	AND ActCloseDate BETWEEN @StartPeriod AND @EndPeriod
END
-----------------------------------------------------------------

DECLARE @ADGT Table
(	SiteContactID int
,	AverageDailyGain numeric(14,6)
,	WeightGained int
,	TotalPigDays int
,	AveragePurchase_Wt int
,	AverageOut_Wt int
,	PigDeath_Qty int
,	LivePigDays int
,	TransferIn_Qty int
,	TransferIn_Wt int
,	TotalHeadProduced int
,	TransportDeath_Qty int
,	Prim_Wt int
,	Cull_Wt int
,	DeadPigsToPacker_Wt int
,	TransferToTailender_Wt int
,	TransferOut_Wt int
,	TransportDeath_Wt int)

Insert Into @ADGT

SELECT
TOP 25 PERCENT
	ADG1.SiteContactID
,   AdjAverageDailyGain = 
		case 
			when @PhaseID = 'NUR'
				then case when case when isnull(ADG1.TotalPigDays,0) <> 0
				then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				else 0 end > 0 then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays 
				+ ((50 - ADG1.AverageOut_Wt) * 0.005) else 0 end 
			
			when @PhaseID = 'FIN'
				then case when case when isnull(ADG1.TotalPigDays,0) <> 0
				then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				else 0 end > 0 then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				+ ((50 - ADG1.AveragePurchase_Wt) * 0.005)
				+ ((270 - ADG1.AverageOut_Wt) * 0.001) else 0 end 
			else case when isnull(ADG1.TotalPigDays,0) <> 0
				then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				else 0 end
		end


--case when isnull(ADG1.TotalPigDays,0) <> 0
--                  then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
--                  else 0
--            end
,	ADG1.WeightGained
,	ADG1.TotalPigDays
,	ADG1.AveragePurchase_Wt
,	ADG1.AverageOut_Wt
,	ADG1.PigDeath_Qty
,	ADG1.LivePigDays
,	ADG1.TransferIn_Qty
,	ADG1.TransferIn_Wt
,	ADG1.TotalHeadProduced
,	ADG1.TransportDeath_Qty
,	ADG1.Prim_Wt
,	ADG1.Cull_Wt
,	ADG1.DeadPigsToPacker_Wt
,	ADG1.TransferToTailender_Wt
,	ADG1.TransferOut_Wt
,	ADG1.TransportDeath_Wt
FROM  (

Select 
SiteContactID,
Phase,
AdjAverageDailyGain = 
		case 
			when @PhaseID = 'NUR'
				then case when case when isnull(Sum(TotalPigDays),0) <> 0
				then isnull(Sum(WeightGained),0) / Sum(TotalPigDays)
				else 0 end > 0 then isnull(Sum(WeightGained),0) / Sum(TotalPigDays) 
				+ ((50 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
				else 0 end) * 0.005) else 0 end 
			
			when @PhaseID = 'FIN'
				then case when case when isnull(Sum(TotalPigDays),0) <> 0
				then isnull(Sum(WeightGained),0) / Sum(TotalPigDays)
				else 0 end > 0 then isnull(Sum(WeightGained),0) / Sum(TotalPigDays)
				+ ((50 - case when isnull(Sum(TransferIn_Qty),0) <> 0
				then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty) else 0 end) * 0.005)
				+ ((270 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
				else 0 end) * 0.001) else 0 end 
			else case when isnull(Sum(TotalPigDays),0) <> 0
				then isnull(Sum(WeightGained),0) / Sum(TotalPigDays)
				else 0 end
		end,


--case when isnull(Sum(TotalPigDays),0) <> 0
--					then isnull(Sum(WeightGained),0) / Sum(TotalPigDays)
--					else 0 end,
Sum(TotalPigDays) TotalPigDays,
Sum(WeightGained) WeightGained,
Sum(PigDeath_Qty) PigDeath_Qty,
Sum(LivePigDays) LivePigDays,
Sum(TransferIn_Qty) TransferIn_Qty,
Sum(TransferIn_Wt) TransferIn_Wt,
Sum(TotalHeadProduced) TotalHeadProduced,
Sum(TransportDeath_Qty) TransportDeath_Qty,
Sum(Prim_Wt) Prim_Wt,
Sum(Cull_Wt) Cull_Wt,
Sum(DeadPigsToPacker_Wt) DeadPigsToPacker_Wt,
Sum(TransferToTailender_Wt) TransferToTailender_Wt,
Sum(TransferOut_Wt) TransferOut_Wt,
Sum(TransportDeath_Wt) TransportDeath_Wt,
AveragePurchase_Wt = case when isnull(Sum(TransferIn_Qty),0) <> 0
					then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty)
					else 0 end,
AverageOut_Wt = case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
					else 0 end
from  dbo.cft_PIG_MASTER_GROUP_ROLLUP
Where ActCloseDate BETWEEN @StartPeriod and @EndPeriod
Group by
SiteContactID,
Phase) ADG1
WHERE ADG1.Phase = @PhaseID
--AND ADG1.AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
--AND ADG1.AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
ORDER BY
		case 
			when @PhaseID = 'NUR'
				then case when case when isnull(ADG1.TotalPigDays,0) <> 0
				then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				else 0 end > 0 then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays 
				+ ((50 - ADG1.AverageOut_Wt) * 0.005) else 0 end 
			
			when @PhaseID = 'FIN'
				then case when case when isnull(ADG1.TotalPigDays,0) <> 0
				then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				else 0 end > 0 then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				+ ((50 - ADG1.AveragePurchase_Wt) * 0.005)
				+ ((270 - ADG1.AverageOut_Wt) * 0.001) else 0 end 
			else case when isnull(ADG1.TotalPigDays,0) <> 0
				then isnull(ADG1.WeightGained,0) / ADG1.TotalPigDays
				else 0 end
		end DESC

DECLARE @AFGT Table
(	SiteContactID int
,	AdjFeedToGain numeric(14,6)
,	Feed_Qty int
,	WeightGained int
,	AveragePurchase_Wt numeric(14,6)
,	AverageOut_Wt numeric(14,6)
,	PigDeath_Qty int
,	LivePigDays int
,	TransferIn_Qty int
,	TransferIn_Wt int
,	TotalHeadProduced int
,	TransportDeath_Qty int
,	Prim_Wt int
,	Cull_Wt int
,	DeadPigsToPacker_Wt int
,	TransferToTailender_Wt int
,	TransferOut_Wt int
,	TransportDeath_Wt int)

Insert Into @AFGT

SELECT TOP 25 PERCENT
	SiteContactID
,	AdjFeedToGain =
		case 
			when @PhaseID = 'NUR'
				then case when isnull(AFG1.WeightGained,0) <> 0
				then isnull(AFG1.Feed_Qty,0) / AFG1.WeightGained
				else 0 end + ((50 - AFG1.AverageOut_Wt) * 0.005)
			when @PhaseID = 'FIN'
				then case when isnull(AFG1.WeightGained,0) <> 0
				then isnull(AFG1.Feed_Qty,0) / AFG1.WeightGained
				else 0 end + ((50 - AFG1.AveragePurchase_Wt) * 0.005) + ((270 - AFG1.AverageOut_Wt) * 0.005)
			else case when isnull(AFG1.WeightGained,0) <> 0
				then isnull(AFG1.Feed_Qty,0) / AFG1.WeightGained
				else 0 end
		end
,	AFG1.Feed_Qty
,	AFG1.WeightGained		
,	AFG1.AveragePurchase_Wt
,	AFG1.AverageOut_Wt
,	AFG1.PigDeath_Qty
,	AFG1.LivePigDays
,	AFG1.TransferIn_Qty
,	AFG1.TransferIn_Wt
,	AFG1.TotalHeadProduced
,	AFG1.TransportDeath_Qty
,	AFG1.Prim_Wt
,	AFG1.Cull_Wt
,	AFG1.DeadPigsToPacker_Wt
,	AFG1.TransferToTailender_Wt
,	AFG1.TransferOut_Wt
,	AFG1.TransportDeath_Wt
FROM	(

Select 
SiteContactID,
Phase,
AdjFeedToGain =
		case 
			when @PhaseID = 'NUR'
				then case when isnull(Sum(WeightGained),0) <> 0
				then isnull(Sum(Feed_Qty),0) / Sum(WeightGained)
				else 0 end + ((50 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
					else 0 end) * 0.005)
			when @PhaseID = 'FIN'
				then case when isnull(Sum(WeightGained),0) <> 0
				then isnull(Sum(Feed_Qty),0) / Sum(WeightGained)
				else 0 end + ((50 - case when isnull(Sum(TransferIn_Qty),0) <> 0
					then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty)
					else 0 end) * 0.005) + ((270 - case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
					else 0 end) * 0.005)
			else case when isnull(Sum(WeightGained),0) <> 0
				then isnull(Sum(Feed_Qty),0) / Sum(WeightGained)
				else 0 end
		end,



--FeedToGain = case when isnull(Sum(WeightGained),0) <> 0
--					then isnull(Sum(Feed_Qty),0) / Sum(WeightGained)
--					else 0 end,
Sum(Feed_Qty) Feed_Qty,
Sum(WeightGained) WeightGained,
Sum(PigDeath_Qty) PigDeath_Qty,
Sum(LivePigDays) LivePigDays,
Sum(TransferIn_Qty) TransferIn_Qty,
Sum(TransferIn_Wt) TransferIn_Wt,
Sum(TotalHeadProduced) TotalHeadProduced,
Sum(TransportDeath_Qty) TransportDeath_Qty,
Sum(Prim_Wt) Prim_Wt,
Sum(Cull_Wt) Cull_Wt,
Sum(DeadPigsToPacker_Wt) DeadPigsToPacker_Wt,
Sum(TransferToTailender_Wt) TransferToTailender_Wt,
Sum(TransferOut_Wt) TransferOut_Wt,
Sum(TransportDeath_Wt) TransportDeath_Wt,
AveragePurchase_Wt = case when isnull(Sum(TransferIn_Qty),0) <> 0
					then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty)
					else 0 end,
AverageOut_Wt = case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
					else 0 end
from  dbo.cft_PIG_MASTER_GROUP_ROLLUP
Where ActCloseDate BETWEEN @StartPeriod and @EndPeriod
Group by
SiteContactID,
Phase) AFG1

WHERE AFG1.Phase = @PhaseID
--AND AFG1.AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
--AND AFG1.AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
ORDER BY
case 
			when @PhaseID = 'NUR'
				then case when isnull(AFG1.WeightGained,0) <> 0
				then isnull(AFG1.Feed_Qty,0) / AFG1.WeightGained
				else 0 end + ((50 - AFG1.AverageOut_Wt) * 0.005)
			when @PhaseID = 'FIN'
				then case when isnull(AFG1.WeightGained,0) <> 0
				then isnull(AFG1.Feed_Qty,0) / AFG1.WeightGained
				else 0 end + ((50 - AFG1.AveragePurchase_Wt) * 0.005) + ((270 - AFG1.AverageOut_Wt) * 0.005)
			else case when isnull(AFG1.WeightGained,0) <> 0
				then isnull(AFG1.Feed_Qty,0) / AFG1.WeightGained
				else 0 end
		end

DECLARE @ADFIT Table
(	SiteContactID int
,	ADFI numeric(14,6)
,	Feed_Qty int
,	TotalPigDays int)

Insert Into @ADFIT

SELECT TOP 25 PERCENT
	SiteContactID
,	ADFI =
		case when isnull(ADFI1.TotalPigDays,0) <> 0
			then isnull(ADFI1.Feed_Qty,0) / ADFI1.TotalPigDays
			else 0
		end
,	ADFI1.Feed_Qty
,	ADFI1.TotalPigDays		
FROM	(

Select 
SiteContactID,
Phase,
FeedToGain = case when isnull(Sum(WeightGained),0) <> 0
					then isnull(Sum(Feed_Qty),0) / Sum(WeightGained)
					else 0 end,
Sum(Feed_Qty) Feed_Qty,
Sum(TotalPigDays) TotalPigDays,
AveragePurchase_Wt = case when isnull(Sum(TransferIn_Qty),0) <> 0
					then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty)
					else 0 end,
AverageOut_Wt = case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
					else 0 end
from  dbo.cft_PIG_MASTER_GROUP_ROLLUP
Where ActCloseDate BETWEEN @StartPeriod and @EndPeriod
Group by
SiteContactID,
Phase) ADFI1

WHERE ADFI1.Phase = @PhaseID
AND ADFI1.AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
AND ADFI1.AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
-- this order by causes us to use the same data set for top 25% as the Adj Feed To Gain's group above
ORDER BY
case 
	when @PhaseID = 'NUR'
		then ADFI1.FeedToGain + ((50 - ADFI1.AverageOut_Wt) * 0.005)
	when @PhaseID = 'FIN'
		then ADFI1.FeedToGain + ((50 - ADFI1.AveragePurchase_Wt) * 0.005) + ((270 - ADFI1.AverageOut_Wt) * 0.005)
	else ADFI1.FeedToGain
end

DECLARE @MORTT Table
(	SiteContactID int
,	Mortality numeric(14,6)
,	PigDeath_Qty int
,	HeadStarted int)

Insert Into @MORTT

SELECT TOP 25 PERCENT
		SiteContactID
	,	Mortality =
			case when isnull(Mort1.HeadStarted,0) <> 0
				then (cast(isnull(Mort1.PigDeath_Qty,0) as numeric(14,2)) / cast(Mort1.HeadStarted as numeric(14,2))) * 100
				else 0
			end
	,	Mort1.PigDeath_Qty
	,	Mort1.HeadStarted
	FROM	(
	
Select 
SiteContactID,
Phase,
Sum(HeadStarted) HeadStarted,
Sum(PigDeath_Qty) PigDeath_Qty,
AveragePurchase_Wt = case when isnull(Sum(TransferIn_Qty),0) <> 0
					then isnull(Sum(TransferIn_Wt),0) / Sum(TransferIn_Qty)
					else 0 end,
AverageOut_Wt = case when (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(Prim_Wt),0) + isnull(Sum(Cull_Wt),0) + isnull(Sum(DeadPigsToPacker_Wt),0) + isnull(Sum(TransferToTailender_Wt),0) + isnull(Sum(TransferOut_Wt),0) + isnull(Sum(TransportDeath_Wt),0)) / (isnull(Sum(TotalHeadProduced),0) + isnull(Sum(TransportDeath_Qty),0))
					else 0 end
from  dbo.cft_PIG_MASTER_GROUP_ROLLUP
Where ActCloseDate BETWEEN @StartPeriod and @EndPeriod
Group by
SiteContactID,
Phase) Mort1
	
	WHERE Mort1.Phase = @PhaseID
	AND Mort1.AveragePurchase_Wt BETWEEN @MinBegWt AND @MaxBegWt
	AND Mort1.AverageOut_Wt BETWEEN @MinEndWt AND @MaxEndWt
	--AND RTRIM(PodDescription) = @PodDescription
	ORDER BY
	case when isnull(Mort1.HeadStarted,0) <> 0
		then (cast(isnull(Mort1.PigDeath_Qty,0) as numeric(14,2)) / cast(Mort1.HeadStarted as numeric(14,2))) * 100
		else 0
	end

DECLARE @ADG NUMERIC(5,2)
--DECLARE @FG NUMERIC(5,2)
DECLARE @AFG NUMERIC(5,2)
DECLARE @ADFI NUMERIC(5,2)
DECLARE @Mort NUMERIC(5,2)
-----------------------------------------------------------------
-- Average Daily Gain
-----------------------------------------------------------------
SELECT 
@ADG =
		case 
			when @PhaseID = 'NUR'
				then case when case when isnull(Sum(ADG.TotalPigDays)*1.00,0) <> 0
				then isnull(Sum(ADG.WeightGained)*1.00,0) / Sum(ADG.TotalPigDays)*1.00
				else 0 end > 0 then isnull(Sum(ADG.WeightGained)*1.00,0) / Sum(ADG.TotalPigDays)*1.00 
				+ ((50 - case when (isnull(Sum(ADG.TotalHeadProduced)*1.00,0) + isnull(Sum(ADG.TransportDeath_Qty)*1.00,0)) <> 0
				then (isnull(Sum(ADG.Prim_Wt)*1.00,0) + isnull(Sum(ADG.Cull_Wt)*1.00,0) + isnull(Sum(ADG.DeadPigsToPacker_Wt)*1.00,0) + isnull(Sum(ADG.TransferToTailender_Wt)*1.00,0) + isnull(Sum(ADG.TransferOut_Wt)*1.00,0) + isnull(Sum(ADG.TransportDeath_Wt)*1.00,0)) / (isnull(Sum(ADG.TotalHeadProduced)*1.00,0) + isnull(Sum(ADG.TransportDeath_Qty)*1.00,0))
				else 0 end) * 0.005) else 0 end 
			
			when @PhaseID = 'FIN'
				then case when case when isnull(Sum(ADG.TotalPigDays)*1.00,0) <> 0
				then isnull(Sum(ADG.WeightGained)*1.00,0) / Sum(ADG.TotalPigDays)*1.00
				else 0 end > 0 then isnull(Sum(ADG.WeightGained)*1.00,0) / Sum(ADG.TotalPigDays)*1.00
				+ ((50 - case when isnull(Sum(ADG.TransferIn_Qty)*1.00,0) <> 0
				then isnull(Sum(ADG.TransferIn_Wt)*1.00,0) / Sum(ADG.TransferIn_Qty)*1.00 else 0 end) * 0.005)
				+ ((270 - case when (isnull(Sum(ADG.TotalHeadProduced)*1.00,0) + isnull(Sum(ADG.TransportDeath_Qty)*1.00,0)) <> 0
				then (isnull(Sum(ADG.Prim_Wt)*1.00,0) + isnull(Sum(ADG.Cull_Wt)*1.00,0) + isnull(Sum(ADG.DeadPigsToPacker_Wt)*1.00,0) + isnull(Sum(ADG.TransferToTailender_Wt)*1.00,0) + isnull(Sum(ADG.TransferOut_Wt)*1.00,0) + isnull(Sum(ADG.TransportDeath_Wt)*1.00,0)) / (isnull(Sum(ADG.TotalHeadProduced)*1.00,0) + isnull(Sum(ADG.TransportDeath_Qty)*1.00,0))
				else 0 end) * 0.001) else 0 end 
			else case when isnull(Sum(ADG.TotalPigDays)*1.00,0) <> 0
				then isnull(Sum(ADG.WeightGained)*1.00,0) / Sum(ADG.TotalPigDays)*1.00
				else 0 end
		end

--CAST(SUM(ADG.WeightGained)*1.00/SUM(ADG.TotalPigDays)*1.00 AS NUMERIC(5,2))

FROM @ADGT ADG

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
SELECT 
@AFG = case 
			when @PhaseID = 'NUR'
				then case when isnull(Sum(AFG.WeightGained)*1.00,0) <> 0
				then isnull(Sum(AFG.Feed_Qty)*1.00,0) / Sum(AFG.WeightGained)*1.00
				else 0 end + ((50 - 
				
				case when (isnull(Sum(AFG.TotalHeadProduced),0) + isnull(Sum(AFG.TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(AFG.Prim_Wt),0) + isnull(Sum(AFG.Cull_Wt),0) + isnull(Sum(AFG.DeadPigsToPacker_Wt),0) + isnull(Sum(AFG.TransferToTailender_Wt),0) + isnull(Sum(AFG.TransferOut_Wt),0) + isnull(Sum(AFG.TransportDeath_Wt),0)) / (isnull(Sum(AFG.TotalHeadProduced),0) + isnull(Sum(AFG.TransportDeath_Qty),0))
				else 0 end
				
				*1.00) * 0.005)
			when @PhaseID = 'FIN'
				then case when isnull(Sum(AFG.WeightGained)*1.00,0) <> 0
				then isnull(Sum(AFG.Feed_Qty)*1.00,0) / Sum(AFG.WeightGained)*1.00
				else 0 end + ((50 - case when isnull(Sum(AFG.TransferIn_Qty),0) <> 0
				then isnull(Sum(AFG.TransferIn_Wt),0) / Sum(AFG.TransferIn_Qty)
				else 0 end * 1.00) * 0.005) + ((270 - 
				
				case when (isnull(Sum(AFG.TotalHeadProduced),0) + isnull(Sum(AFG.TransportDeath_Qty),0)) <> 0
				then (isnull(Sum(AFG.Prim_Wt),0) + isnull(Sum(AFG.Cull_Wt),0) + isnull(Sum(AFG.DeadPigsToPacker_Wt),0) + isnull(Sum(AFG.TransferToTailender_Wt),0) + isnull(Sum(AFG.TransferOut_Wt),0) + isnull(Sum(AFG.TransportDeath_Wt),0)) / (isnull(Sum(AFG.TotalHeadProduced),0) + isnull(Sum(AFG.TransportDeath_Qty),0))
				else 0 end
				
				*1.00) * 0.005)
			else case when isnull(Sum(AFG.WeightGained)*1.00,0) <> 0
				then isnull(Sum(AFG.Feed_Qty)*1.00,0) / Sum(AFG.WeightGained)*1.00
				else 0 end
		end
FROM @AFGT AFG


-----------------------------------------------------------------
-- Average Daily Feed Intake
-----------------------------------------------------------------
SELECT 
@ADFI = CAST(SUM(ISNULL(ADFI.Feed_Qty,0)*1.00) / SUM(ADFI.TotalPigDays)*1.00 AS NUMERIC(5,2))
FROM @ADFIT ADFI

-----------------------------------------------------------------
-- Mortality
-----------------------------------------------------------------

SELECT 
@Mort = CAST((CAST(SUM(ISNULL(Mort.PigDeath_Qty,0))*1.00 AS NUMERIC(14,2)) / CAST(SUM(Mort.HeadStarted)*1.00 AS NUMERIC(14,2))) * 100 AS NUMERIC(5,2))
FROM @MORTT Mort


-----------------------------------------------------------------
-- Report Data
-----------------------------------------------------------------
SELECT
	--RTRIM(TaskID) TaskID
	--RTRIM(mgr.MasterGroup) MasterGroup
--	RTRIM(mgr.SiteContactID) SiteContactID
--,	RTRIM(c.ContactName) as SiteName
--,	mgr.PigFlowID
	mgr.FYPeriod
,	mgr.Phase
--,	RTRIM(pf.PigFlowDescription) as PigFlow
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
,	AdjFeedToGain = case 
			when @PhaseID = 'NUR'
				then case when isnull(Sum(mgr.WeightGained),0) <> 0
				then isnull(Sum(mgr.Feed_Qty),0) / Sum(mgr.WeightGained)
				else 0 end + ((50 - case when (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(mgr.Prim_Wt),0) + isnull(Sum(mgr.Cull_Wt),0) + isnull(Sum(mgr.DeadPigsToPacker_Wt),0) + isnull(Sum(mgr.TransferToTailender_Wt),0) + isnull(Sum(mgr.TransferOut_Wt),0) + isnull(Sum(mgr.TransportDeath_Wt),0)) / (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0))
					else 0 end) * 0.005)
			when @PhaseID = 'FIN'
				then case when isnull(Sum(mgr.WeightGained),0) <> 0
				then isnull(Sum(mgr.Feed_Qty),0) / Sum(mgr.WeightGained)
				else 0 end + ((50 - case when isnull(Sum(mgr.TransferIn_Qty),0) <> 0
					then isnull(Sum(mgr.TransferIn_Wt),0) / Sum(mgr.TransferIn_Qty)
					else 0 end) * 0.005) + ((270 - case when (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0)) <> 0
					then (isnull(Sum(mgr.Prim_Wt),0) + isnull(Sum(mgr.Cull_Wt),0) + isnull(Sum(mgr.DeadPigsToPacker_Wt),0) + isnull(Sum(mgr.TransferToTailender_Wt),0) + isnull(Sum(mgr.TransferOut_Wt),0) + isnull(Sum(mgr.TransportDeath_Wt),0)) / (isnull(Sum(mgr.TotalHeadProduced),0) + isnull(Sum(mgr.TransportDeath_Qty),0))
					else 0 end) * 0.005)
			else case when isnull(Sum(mgr.WeightGained),0) <> 0
				then isnull(Sum(mgr.Feed_Qty),0) / Sum(mgr.WeightGained)
				else 0 end
		end
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
,	SUM(mgr.PIGS_TRUCKING_COST) PigTruckingCost
,	SUM(mgr.PIGS_SITE_COST) PigSiteCost
,	SUM(mgr.PIGS_RM_COST) PigRMCost
,	SUM(mgr.PIGS_VET_COST) PigVetCost
,	SUM(mgr.PIGS_SUPPLY_COST) PigSupplyCost
,	SUM(mgr.PIGS_DEATH) PigDeathCost
,	SUM(mgr.PIGS_TRANSPORT_COST) PigTransportCost
,	SUM(mgr.PIGS_OVR_HD_COST) PigOvrHdCost
,	SUM(mgr.PIGS_OVR_HD_CHG) PigOvhHdChg
,	SUM(mgr.PIGS_INT_WC_CHG) PigIntWCChg
,	SUM(mgr.PIGS_MISC_EXP_CHG) PigMiscExpChg
,	@ADG ADGTop25Pct
--,	@FG FGTopTenPct
,	@AFG AdjFGTop25Pct
,	@ADFI ADFITop25Pct
,	@Mort MortTop25Pct
--,	ADGTop25PctSite = Case when mgr.SiteContactID in (Select Distinct SiteContactID from @ADGT)
--	then 1 else 0 end 
--,	AdjFGTop25PctSite = Case when mgr.SiteContactID in (Select Distinct SiteContactID from @AFGT)
--	then 1 else 0 end 
--,	ADFITop25PctSite = Case when mgr.SiteContactID in (Select Distinct SiteContactID from @ADFIT)
--	then 1 else 0 end 
--,	MortTop25PctSite = Case when mgr.SiteContactID in (Select Distinct SiteContactID from @MORTT)
--	then 1 else 0 end 

FROM (
	Select 
	Case when WD.FiscalPeriod < 10 
	then Rtrim(CAST(WD.FiscalYear AS char)) + '0' + Rtrim(CAST(WD.FiscalPeriod AS char)) 
	else Rtrim(CAST(WD.FiscalYear AS char)) + Rtrim(CAST(WD.FiscalPeriod AS char)) end FYPeriod,
	sr.Phase,
	Sum(sr.LivePigDays) LivePigDays,
	Sum(sr.DeadPigDays) DeadPigDays,
	Sum(sr.TotalPigDays) TotalPigDays,
	Sum(sr.Feed_Qty) Feed_Qty,
	Sum(sr.TransferIn_Qty) TransferIn_Qty,
	Sum(sr.MoveIn_Qty) MoveIn_Qty,
	Sum(sr.MoveOut_Qty) MoveOut_Qty,
	Sum(sr.PigDeath_Qty) PigDeath_Qty,
	Sum(sr.TransferOut_Qty) TransferOut_Qty,
	Sum(sr.TransferToTailender_Qty) TransferToTailender_Qty,
	Sum(sr.Prim_Qty) Prim_Qty,
	Sum(sr.Cull_Qty) Cull_Qty,
	Sum(sr.DeadPigsToPacker_Qty) DeadPigsToPacker_Qty,
	Sum(sr.TransportDeath_Qty) TransportDeath_Qty,
	Sum(sr.InventoryAdjustment_Qty) InventoryAdjustment_Qty,
	Sum(sr.Top_Qty) Top_Qty,
	Sum(sr.TransferIn_Wt) TransferIn_Wt,
	Sum(sr.MoveIn_Wt) MoveIn_Wt,
	Sum(sr.MoveOut_Wt) MoveOut_Wt,
	Sum(sr.TransferOut_Wt) TransferOut_Wt,
	Sum(sr.TransferToTailender_Wt) TransferToTailender_Wt,
	Sum(sr.Prim_Wt) Prim_Wt,
	Sum(sr.Cull_Wt) Cull_Wt,
	Sum(sr.DeadPigsToPacker_Wt) DeadPigsToPacker_Wt,
	Sum(sr.TransportDeath_Wt) TransportDeath_Wt,
	Sum(sr.Top_Wt) Top_Wt,
	Sum(sr.MedicationCost) MedicationCost,
	Sum(sr.WeightGained) WeightGained,
	Sum(sr.HeadStarted) HeadStarted,
	Sum(sr.TotalHeadProduced) TotalHeadProduced,
	Sum(sr.VaccinationCost) VaccinationCost,
	Sum(sr.FeedCost) FeedCost,
	Sum(sr.HeadSold) HeadSold,
	Sum(sr.DaysInGroup) DaysInGroup,
	Sum(sr.EmptyDays) EmptyDays,
	Sum(sr.PigCapacityDays) PigCapacityDays,
	Sum(sr.EmptyCapacityDays) EmptyCapacityDays,
	Sum(sr.HeadCapacity) HeadCapacity,
	Sum(COG.PIGS_TRUCKING_COST) PIGS_TRUCKING_COST,
	Sum(COG.PIGS_SITE_COST) PIGS_SITE_COST,
	Sum(COG.PIGS_RM_COST) PIGS_RM_COST,
	Sum(COG.PIGS_VET_COST) PIGS_VET_COST,
	Sum(COG.PIGS_SUPPLY_COST) PIGS_SUPPLY_COST,
	Sum(COG.PIGS_DEATH) PIGS_DEATH,
	Sum(COG.PIGS_TRANSPORT_COST) PIGS_TRANSPORT_COST,
	Sum(COG.PIGS_OVR_HD_COST) PIGS_OVR_HD_COST,
	Sum(COG.PIGS_OVR_HD_CHG) PIGS_OVR_HD_CHG,
	Sum(COG.PIGS_INT_WC_CHG) PIGS_INT_WC_CHG,
	Sum(COG.PIGS_MISC_EXP_CHG) PIGS_MISC_EXP_CHG
	from  dbo.cft_PIG_MASTER_GROUP_ROLLUP sr
	left join [$(SolomonApp)].dbo.cfvDayDefinition_WithWeekInfo WD
	on sr.actclosedate = WD.daydate

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
	case when pjp.Acct in ('PIGS OVR HD COST') then sum(pjp.act_amount) else 0 end as PIGS_OVR_HD_COST,
	case when pjp.Acct in ('PIGS OVR HD CHG') then sum(pjp.act_amount) else 0 end as PIGS_OVR_HD_CHG,
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
	on sr.MasterGroup = COG.MasterGroup
	
	Where sr.ActCloseDate between @SysStartPeriod and @EndPeriod
	
	Group by
	Case when WD.FiscalPeriod < 10 
	then Rtrim(CAST(WD.FiscalYear AS char)) + '0' + Rtrim(CAST(WD.FiscalPeriod AS char)) 
	else Rtrim(CAST(WD.FiscalYear AS char)) + Rtrim(CAST(WD.FiscalPeriod AS char)) end,
	sr.Phase) mgr

--left join [$(SolomonApp)].dbo.cftContact c
--on mgr.SiteContactID = c.ContactID 
--left join [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW pf
--on mgr.PigFlowID = pf.PigFlowID
WHERE mgr.Phase = @PhaseID
--	RTRIM(MasterGroup) = '26570'
GROUP BY
--	mgr.SiteContactID
--,	c.ContactName
--,	mgr.PigFlowID
--,	pf.PigFlowDescription
--,	mgr.ActCloseDate
--,	mgr.ActStartDate
--,	mgr.SrSvcManager
--,	mgr.SvcManager
	mgr.FYPeriod
,	mgr.Phase
ORDER BY mgr.FYPeriod

----PRINT 'PicStartDate = ' + cast(@PicStartDate as varchar)
----PRINT 'PicEndDate = ' + cast(@PicEndDate as varchar)




GO
GRANT EXECUTE
    ON OBJECT::[dbo].[cfp_MONTHLY_NURSERY_REPORT_SYSTEM] TO [db_sp_exec]
    AS [dbo];

