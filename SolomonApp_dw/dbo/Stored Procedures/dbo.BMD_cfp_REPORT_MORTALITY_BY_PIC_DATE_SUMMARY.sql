


CREATE PROCEDURE [dbo].[BMD_cfp_REPORT_MORTALITY_BY_PIC_DATE_SUMMARY]
	@PicDate CHAR(6)
,	@NumWeeks int
AS

---------------------------------------------------------------------
--pic dates
---------------------------------------------------------------------
DECLARE @PicYear char(4)
DECLARE @PicWeek char(2)
DECLARE @PicStartDate datetime
DECLARE @PicStartDateSingle datetime
DECLARE @PicEndDate datetime
SET @PicYear = '20' + LEFT(@PicDate,2)
SET @PicWeek = RIGHT(@PicDate,2)

SELECT @PicEndDate = WeekEndDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE PicYear = CAST(@PicYear AS INT) AND PicWeek = CAST(@PicWeek AS INT)
SELECT @PicStartDate = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE DATEADD(wk,-@NumWeeks,@PicEndDate) BETWEEN WeekOfDate AND WeekEndDate
SELECT @PicStartDateSingle = WeekOfDate FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK) WHERE DATEADD(wk,-0,@PicEndDate) BETWEEN WeekOfDate AND WeekEndDate

---------------------------------------------------------------------
--first week
---------------------------------------------------------------------
CREATE TABLE #PicRange (PicDate char(6))
INSERT INTO #PicRange
SELECT CAST(RIGHT(PicYear,2) AS VARCHAR) + 'WK' + RIGHT('0' + CAST(PicWeek AS VARCHAR),2) PicDate
FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
WHERE	WeekOfDate >= @PicStartDateSingle
AND		WeekEndDate <= @PicEndDate

---------------------------------------------------------------------
--all weeks
---------------------------------------------------------------------
CREATE TABLE #PicRangeFull (PicDate char(6))
INSERT INTO #PicRangeFull
SELECT CAST(RIGHT(PicYear,2) AS VARCHAR) + 'WK' + RIGHT('0' + CAST(PicWeek AS VARCHAR),2) PicDate
FROM [$(SolomonApp)].dbo.cftWeekDefinition (NOLOCK)
WHERE	WeekOfDate >= @PicStartDate
AND		WeekEndDate <= @PicEndDate

---------------------------------------------------------------------
--eligible pigflowid's and phases
--only eligible if the pigflowid and pigprodphaseid have data for first week
---------------------------------------------------------------------
CREATE TABLE #ReportSites (PigFlowID int, PigProdPhaseID char(3))
INSERT INTO #ReportSites
select distinct PigFlowID, PigProdPhaseID
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
WHERE EXISTS (SELECT x.* FROM  dbo.cft_PIG_GROUP_CENSUS x (NOLOCK)
		WHERE x.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
		AND x.PICYear_Week = @PicDate)
AND cft_PIG_GROUP_CENSUS.PICYear_Week = @PicDate

---------------------------------------------------------------------
--target line data
---------------------------------------------------------------------
DECLARE @MortalityPercentAllTargetLine DECIMAL(10,3)
DECLARE @MortalityPercentFinishingTargetLine DECIMAL(10,3)
DECLARE @MortalityPercentNurseryTargetLine DECIMAL(10,3)
DECLARE @MortalityPercentWeanToFinishTargetLine DECIMAL(10,3)

select @MortalityPercentAllTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 19

select @MortalityPercentFinishingTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 20

select @MortalityPercentNurseryTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 21

select @MortalityPercentWeanToFinishTargetLine = TargetLineValue
from [$(CFApp_PigManagement)].dbo.cft_TARGET_LINE
where TargetLineTypeID = 27



---------------------------------------------------------------------
--get data
---------------------------------------------------------------------
CREATE TABLE #ReportData
(	PigFlowID int
,	PigFlowDescription varchar(100)
,	PICYear_Week char(6)
,	PigProdPhaseID char(3)
,	SvcManager varchar(100)
,	SrSvcManager varchar(100)
,	SUMCurrentInv int
,	SUMPigDeaths int
,	AVGMortalityPercent numeric(10,2)
,	CumulativeAVGMortalityPercent numeric(10,2)
,	CumulativeAVGMortalityPercentByPhaseAndPigFlowID numeric(10,2)
,	SUMCumulativePigDeaths int
,	MortalityPercentAllTargetLine decimal(10,3)
,	MortalityPercentFinishingTargetLine decimal(10,3)
,	MortalityPercentNurseryTargetLine decimal(10,3)
,   MortalityPercentWeanToFinishTargetLine decimal(10,3))

INSERT INTO #ReportData
SELECT 
	cft_PIG_GROUP_CENSUS.PigFlowID
,	cft_PIG_FLOW.PigFlowDescription
,	cft_PIG_GROUP_CENSUS.PICYear_Week
,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
,	cft_PIG_GROUP_CENSUS.SvcManager
,	cft_PIG_GROUP_CENSUS.SrSvcManager
,	SUM(cft_PIG_GROUP_CENSUS.CurrentInv) SUMCurrentInv
,	SUM(cft_PIG_GROUP_CENSUS.PigDeaths) SUMPigDeaths
,	CASE WHEN CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2)) = 0
		THEN 0
		ELSE CAST((CAST(SUM(cft_PIG_GROUP_CENSUS.PigDeaths) AS NUMERIC(10,2)) / CAST(SUM(cft_PIG_GROUP_CENSUS.CurrentInv) AS NUMERIC(10,2))) * 100 AS NUMERIC(10,2))
	END AVGMortalityPercent
,	NULL
,	NULL
,	SUM(cft_PIG_GROUP_CENSUS.CumulativePigDeaths) SUMCumulativePigDeaths
,	@MortalityPercentAllTargetLine MortalityPercentAllTargetLine
,	@MortalityPercentFinishingTargetLine MortalityPercentFinishingTargetLine
,	@MortalityPercentNurseryTargetLine MortalityPercentNurseryTargetLine
,   @MortalityPercentWeanToFinishTargetLine MortalityPercentWeanToFinishTargetLine
FROM  dbo.cft_PIG_GROUP_CENSUS cft_PIG_GROUP_CENSUS (NOLOCK)
JOIN [$(CFApp_PigManagement)].dbo.cft_PIG_FLOW cft_PIG_FLOW (NOLOCK)
	ON cft_PIG_FLOW.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
JOIN #PicRangeFull PicRange
	ON PicRange.PicDate = cft_PIG_GROUP_CENSUS.PICYear_Week
JOIN #ReportSites ReportSites
	ON ReportSites.PigFlowID = cft_PIG_GROUP_CENSUS.PigFlowID
	AND ReportSites.PigProdPhaseID = cft_PIG_GROUP_CENSUS.PigProdPhaseID
GROUP BY 
	cft_PIG_GROUP_CENSUS.PigFlowID
,	cft_PIG_FLOW.PigFlowDescription
,	cft_PIG_GROUP_CENSUS.PICYear_Week
,	cft_PIG_GROUP_CENSUS.PigProdPhaseID
,	cft_PIG_GROUP_CENSUS.SvcManager
,	cft_PIG_GROUP_CENSUS.SrSvcManager
ORDER BY
	cft_PIG_GROUP_CENSUS.PICYear_Week desc
,	cft_PIG_FLOW.PigFlowDescription

UPDATE	#ReportData
SET	CumulativeAVGMortalityPercent = x.CumulativeAVGMortalityPercent
FROM	(SELECT AVG(AVGMortalityPercent) CumulativeAVGMortalityPercent FROM #ReportData) x

UPDATE	#ReportData
SET	CumulativeAVGMortalityPercentByPhaseAndPigFlowID = x.CumulativeAVGMortalityPercent
FROM	#ReportData ReportData
JOIN	(SELECT PigFlowID, PigProdPhaseID, AVG(AVGMortalityPercent) CumulativeAVGMortalityPercent FROM #ReportData GROUP BY PigFlowID, PigProdPhaseID) x
	ON x.PigFlowID = ReportData.PigFlowID
	AND x.PigProdPhaseID = ReportData.PigProdPhaseID
	
IF @NumWeeks <> 5
BEGIN
	---------------------------------------------------------------------
	--insert dummy records for graphs
	---------------------------------------------------------------------
	select *
	into #build
	from #PicRangeFull PicRange
	CROSS JOIN (SELECT DISTINCT PigFlowID, PigFlowDescription, PigProdPhaseID, SvcManager, SrSvcManager, CumulativeAVGMortalityPercentByPhaseAndPigFlowID FROM #ReportData) ReportData

	insert into #ReportData
	select PigFlowID,PigFlowDescription,PicDate,PigProdPhaseID,SvcManager,SrSvcManager,NULL,NULL,NULL,NULL,CumulativeAVGMortalityPercentByPhaseAndPigFlowID,NULL,NULL,NULL,NULL,NULL
	from #build build
	where not exists
	(select * from #ReportData 
	where	PICYear_Week = build.PicDate
	and		PigFlowID = build.PigFlowID
	and		PigFlowDescription = build.PigFlowDescription
	and		PigProdPhaseID = build.PigProdPhaseID
	and		SvcManager = build.SvcManager
	and		SrSvcManager = build.SrSvcManager
	and		CumulativeAVGMortalityPercentByPhaseAndPigFlowID = build.CumulativeAVGMortalityPercentByPhaseAndPigFlowID)


	DROP TABLE #build
	---------------------------------------------------------------------
	--END: insert dummy records for graphs
	---------------------------------------------------------------------
END

select PicYear_week, PigProdPhaseID as [PigProdPhase], round((cast(SUM(sumpigdeaths)as float) / cast(SUM(sumcurrentinv) as Float))*100,2) as [MortalityPCT]
from #ReportData
where pigprodphaseid in ('FIN','WTF','NUR')
group by PicYear_week, PigProdPhaseID
order by 1,2

DROP TABLE #ReportData
DROP TABLE #PicRange
DROP TABLE #PicRangeFull
DROP TABLE #ReportSites





